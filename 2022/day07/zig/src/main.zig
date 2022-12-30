const std = @import("std");

const State = enum {
    command,
    response,
};

const File = struct {
    name: []const u8,
    size: usize,
};

const Folder = struct {
    name: []const u8,
    children: std.StringArrayHashMapUnmanaged(Entry) = .{},
    parent: *Folder,
};

const Entry = union(enum) {
    file: File,
    folder: Folder,
};

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    const ally = arena.allocator();

    const input = try std.fs.cwd().readFileAlloc(ally, "../input.txt", 1024 * 1024);

    var root = Folder{ .name = "/", .parent = undefined };
    root.parent = &root;
    var current_folder = &root;

    var state = State.command;

    var line_it = std.mem.tokenize(u8, input, "\n");
    while (line_it.next()) |line| {
        var word_it = std.mem.tokenize(u8, line, " ");

        const possible_command = word_it.peek().?;
        if (std.mem.eql(u8, possible_command, "$")) {
            _ = word_it.next();
            const command = word_it.next().?;
            if (std.mem.eql(u8, command, "cd")) {
                const folder_name = word_it.next().?;

                if (std.mem.eql(u8, folder_name, "/")) {
                    current_folder = &root;
                } else if (std.mem.eql(u8, folder_name, "..")) {
                    current_folder = current_folder.parent;
                } else {
                    var result = try current_folder.children.getOrPut(ally, folder_name);
                    if (!result.found_existing) {
                        result.value_ptr.* = .{ .folder = .{ .name = folder_name, .parent = current_folder } };
                    }
                    current_folder = &result.value_ptr.folder;
                }
            } else {
                state = .response;
            }
        } else {
            const dir_or_size = word_it.next().?;
            if (std.mem.eql(u8, dir_or_size, "dir")) {
                const folder_name = word_it.next().?;
                var result = try current_folder.children.getOrPut(ally, folder_name);
                if (!result.found_existing) {
                    result.value_ptr.* = .{ .folder = .{ .name = folder_name, .parent = current_folder } };
                }
            } else {
                const size = try std.fmt.parseUnsigned(usize, dir_or_size, 0);
                const file_name = word_it.next().?;
                try current_folder.children.put(ally, file_name, .{ .file = .{ .name = file_name, .size = size } });
            }
        }
    }

    const writer = std.io.getStdOut().writer();
    try printEntry(writer, .{ .folder = root }, 0);

    const sizes = try filterDirectories(root);

    std.debug.print("{any}\n", .{sizes});
}

const Sizes = struct {
    children: usize = 0,
    total: usize = 0,
};

fn filterDirectories(folder: Folder) !Sizes {
    var sizes = Sizes{};

    for (folder.children.entries.items(.value)) |entry| {
        switch (entry) {
            .folder => |f| {
                const result = try filterDirectories(f);
                sizes.total += result.total;
                sizes.children += result.children;
            },
            .file => |f| {
                sizes.children += f.size;
            },
        }
    }

    if (sizes.children <= 100_000) {
        sizes.total += sizes.children;
    }

    return sizes;
}

fn printEntry(writer: anytype, entry: Entry, indent: usize) !void {
    switch (entry) {
        .folder => |folder| {
            try writer.writeByteNTimes(' ', indent);
            try writer.print("- {s} (dir)\n", .{folder.name});
            for (folder.children.entries.items(.value)) |child| {
                try printEntry(writer, child, indent + 2);
            }
        },
        .file => |file| {
            try writer.writeByteNTimes(' ', indent);
            try writer.print("- {s} (file, size={})\n", .{ file.name, file.size });
        },
    }
}
