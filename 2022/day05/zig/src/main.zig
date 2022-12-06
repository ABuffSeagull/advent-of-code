const std = @import("std");

const Crate = enum(u8) { _ };

const Stack = std.ArrayList(Crate);

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const ally = gpa.allocator();

    const input = try std.fs.cwd().readFileAlloc(ally, "../input.txt", 1024 * 1024);
    defer ally.free(input);

    try part1(ally, input);
    try part2(ally, input);
}

pub fn part1(ally: std.mem.Allocator, input: []const u8) !void {
    var stacks = std.ArrayList(Stack).init(ally);
    defer {
        for (stacks.items) |stack| stack.deinit();
        stacks.deinit();
    }

    var line_it = std.mem.tokenize(u8, input, "\n");

    crate_parser: while (line_it.next()) |line| {
        var chunk_it = chunkSlice(line, 4);

        var index: usize = 0;
        while (chunk_it.next()) |chunk| {
            defer index += 1;

            if (index >= stacks.items.len) {
                try stacks.append(Stack.init(ally));
            }

            switch (chunk[1]) {
                ' ' => {},
                'A'...'Z' => {
                    try stacks.items[index].append(@intToEnum(Crate, chunk[1]));
                },
                else => break :crate_parser,
            }
        }
    }

    for (stacks.items) |stack| {
        std.mem.reverse(Crate, stack.items);
    }

    while (line_it.next()) |line| {
        var buffer_stream = std.io.fixedBufferStream(line);
        var reader = buffer_stream.reader();

        try reader.skipUntilDelimiterOrEof(' '); // move

        var num_buffer = [_]u8{undefined} ** 16;
        var num_string = try reader.readUntilDelimiterOrEof(&num_buffer, ' ');
        var count = try std.fmt.parseUnsigned(isize, num_string.?, 0);

        try reader.skipUntilDelimiterOrEof(' '); // from

        num_string = try reader.readUntilDelimiterOrEof(&num_buffer, ' ');
        const from = try std.fmt.parseUnsigned(usize, num_string.?, 0);

        try reader.skipUntilDelimiterOrEof(' '); // to

        num_string = try reader.readUntilDelimiterOrEof(&num_buffer, ' ');
        const to = try std.fmt.parseUnsigned(usize, num_string.?, 0);

        while (count > 0) : (count -= 1) {
            try stacks.items[to - 1].append(stacks.items[from - 1].pop());
        }
    }

    std.debug.print("Part 1: ", .{});
    for (stacks.items) |stack| {
        std.debug.print("{c}", .{@enumToInt(stack.items[stack.items.len - 1])});
    }
    std.debug.print("\n", .{});
}

pub fn part2(ally: std.mem.Allocator, input: []const u8) !void {
    var stacks = std.ArrayList(Stack).init(ally);
    defer {
        for (stacks.items) |stack| stack.deinit();
        stacks.deinit();
    }

    var line_it = std.mem.tokenize(u8, input, "\n");

    crate_parser: while (line_it.next()) |line| {
        var chunk_it = chunkSlice(line, 4);

        var index: usize = 0;
        while (chunk_it.next()) |chunk| {
            defer index += 1;

            if (index >= stacks.items.len) {
                try stacks.append(Stack.init(ally));
            }

            switch (chunk[1]) {
                ' ' => {},
                'A'...'Z' => {
                    try stacks.items[index].append(@intToEnum(Crate, chunk[1]));
                },
                else => break :crate_parser,
            }
        }
    }

    for (stacks.items) |stack| {
        std.mem.reverse(Crate, stack.items);
    }

    while (line_it.next()) |line| {
        var buffer_stream = std.io.fixedBufferStream(line);
        var reader = buffer_stream.reader();

        try reader.skipUntilDelimiterOrEof(' '); // move

        var num_buffer = [_]u8{undefined} ** 16;
        var num_string = try reader.readUntilDelimiterOrEof(&num_buffer, ' ');
        const count = try std.fmt.parseUnsigned(usize, num_string.?, 0);

        try reader.skipUntilDelimiterOrEof(' '); // from

        num_string = try reader.readUntilDelimiterOrEof(&num_buffer, ' ');
        const from = try std.fmt.parseUnsigned(usize, num_string.?, 0);

        try reader.skipUntilDelimiterOrEof(' '); // to

        num_string = try reader.readUntilDelimiterOrEof(&num_buffer, ' ');
        const to = try std.fmt.parseUnsigned(usize, num_string.?, 0);

        var from_stack = stacks.items[from - 1];

        const slice = from_stack.items[from_stack.items.len - count .. from_stack.items.len];

        try stacks.items[to - 1].appendSlice(slice);
        try from_stack.resize(from_stack.items.len - count);
        stacks.items[from - 1] = from_stack;
    }

    std.debug.print("Part 2: ", .{});
    for (stacks.items) |stack| {
        std.debug.print("{c}", .{@enumToInt(stack.items[stack.items.len - 1])});
    }
    std.debug.print("\n", .{});
}

fn chunkSlice(slice: []const u8, comptime size: usize) ChunkIterator(size) {
    return ChunkIterator(size){ .slice = slice };
}

fn ChunkIterator(comptime size: usize) type {
    return struct {
        slice: []const u8,
        index: usize = 0,

        const Self = @This();

        fn next(it: *Self) ?[]const u8 {
            if (it.index < it.slice.len) {
                const end = std.math.min(it.index + size, it.slice.len);
                const chunk = it.slice[it.index..end];
                it.index += size;
                return chunk;
            } else {
                return null;
            }
        }
    };
}
