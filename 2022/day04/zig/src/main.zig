const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const ally = gpa.allocator();

    var input_buffer = [_]u8{undefined} ** (1024 * 1024);

    const input = try std.fs.cwd().readFile("../input.txt", &input_buffer);

    try part1(ally, input);
    try part2(ally, input);
}

fn part1(ally: std.mem.Allocator, input: []const u8) !void {
    var contained_pairs: usize = 0;

    var line_it = std.mem.tokenize(u8, input, "\n");
    var index: usize = 0;
    while (line_it.next()) |line| {
        defer index += 1;
        var pair_it = std.mem.tokenize(u8, line, ",");

        var first = try parsePair(ally, pair_it.next().?);
        defer first.deinit();
        var second = try parsePair(ally, pair_it.next().?);
        defer second.deinit();

        const max_size = std.math.max(first.capacity(), second.capacity());
        try first.resize(max_size, false);
        try second.resize(max_size, false);

        const before_first = first.count();
        const before_second = second.count();
        first.setUnion(second);

        const after = first.count();

        if (before_first == after or before_second == after) {
            contained_pairs += 1;
        }
    }

    std.debug.print("Contained Pairs: {}\n", .{contained_pairs});
}

fn part2(ally: std.mem.Allocator, input: []const u8) !void {
    var overlapping_pairs: usize = 0;

    var line_it = std.mem.tokenize(u8, input, "\n");
    var index: usize = 0;
    while (line_it.next()) |line| {
        defer index += 1;
        var pair_it = std.mem.tokenize(u8, line, ",");

        var first = try parsePair(ally, pair_it.next().?);
        defer first.deinit();
        var second = try parsePair(ally, pair_it.next().?);
        defer second.deinit();

        const max_size = std.math.max(first.capacity(), second.capacity());
        try first.resize(max_size, false);
        try second.resize(max_size, false);

        first.setIntersection(second);

        if (first.count() > 0) {
            overlapping_pairs += 1;
        }
    }

    std.debug.print("Overlapping Pairs: {}\n", .{overlapping_pairs});
}

fn parsePair(ally: std.mem.Allocator, input: []const u8) !std.DynamicBitSet {
    var section_it = std.mem.tokenize(u8, input, "-");

    const start = try std.fmt.parseUnsigned(usize, section_it.next().?, 10);
    const end = try std.fmt.parseUnsigned(usize, section_it.next().?, 10) + 1;

    var bit_set = try std.DynamicBitSet.initEmpty(ally, std.math.max(start, end));
    bit_set.setRangeValue(.{ .start = start, .end = end }, true);

    return bit_set;
}
