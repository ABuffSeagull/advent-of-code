const std = @import("std");

pub fn main() !void {
    var input_buffer = [_]u8{undefined} ** (1024 * 1024);
    const input = try std.fs.cwd().readFile("../input.txt", &input_buffer);

    var index: usize = 0;
    while (index + 4 < input.len) : (index += 1) {
        const slice = input[index .. index + 4];

        var bit_set = std.StaticBitSet(std.math.maxInt(u8)).initEmpty();

        for (slice) |char| bit_set.set(char);

        if (bit_set.count() == 4) {
            break;
        }
    }

    std.debug.print("first marker: {}\n", .{index + 4});
}
