const std = @import("std");

pub fn main() !void {
    var input_buffer = [_]u8{undefined} ** (1024 * 1024);
    const input = try std.fs.cwd().readFile("../input.txt", &input_buffer);

    std.debug.print("part1: {}, part2: {}\n", .{
        findMarker(input, 4),
        findMarker(input, 14),
    });
}

fn findMarker(input: []const u8, unique_char_count: usize) usize {
    var index: usize = 0;
    while (index + unique_char_count < input.len) : (index += 1) {
        const slice = input[index .. index + unique_char_count];

        var bit_set = std.StaticBitSet(std.math.maxInt(u8)).initEmpty();

        for (slice) |char| bit_set.set(char);

        if (bit_set.count() == unique_char_count) {
            break;
        }
    }

    return index + unique_char_count;
}
