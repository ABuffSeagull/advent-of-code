const std = @import("std");
const fs = std.fs;
const mem = std.mem;

const HashSet = std.AutoHashMap(u32, u0);

const file = @embedFile("../input.txt");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var allocator = &arena.allocator;

    var hash_set = HashSet.init(allocator);
    defer hash_set.deinit();

    // hehehe, hardcoding the input size
    try hash_set.ensureCapacity(200);

    var spliterator = mem.tokenize(file, "\n");
    while (spliterator.next()) |num_string| {
        const num = try std.fmt.parseUnsigned(u32, num_string, 10);
        hash_set.putAssumeCapacity(num, 0);
    }

    part2(hash_set);
}

fn part1(hash_set: HashSet) void {
    var entries = hash_set.iterator();
    while (entries.next()) |entry| {
        const other_num = 2020 - entry.key;
        if (hash_set.contains(other_num)) {
            std.debug.print("{}\n", .{entry.key * other_num});
            return;
        }
    }
}

fn part2(hash_set: HashSet) void {
    var entries_outer = hash_set.iterator();
    while (entries_outer.next()) |entry_outer| {
        var entries_inner = hash_set.iterator();
        while (entries_inner.next()) |entry_inner| {
            // check for underflow
            if (std.math.sub(u32, 2020 - entry_outer.key, entry_inner.key)) |third_num| {
                if (hash_set.contains(third_num)) {
                    std.debug.print("{}\n", .{entry_outer.key * entry_inner.key * third_num});
                    return;
                }
                // ignore underflows
            } else |err| {}
        }
    }
}
