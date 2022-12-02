const std = @import("std");

const Option = enum {
    rock,
    paper,
    scissors,
};

pub fn main() !void {
    var input_buffer = [_]u8{undefined} ** (1024 * 1024);

    const input = try std.fs.cwd().readFile("../input.txt", &input_buffer);

    var line_it = std.mem.tokenize(u8, input, "\n");

    var score: usize = 0;
    while (line_it.next()) |line| {
        const them: Option = switch (line[0]) {
            'A' => .rock,
            'B' => .paper,
            'C' => .scissors,
            else => unreachable,
        };
        const me: Option = switch (line[2]) {
            'X' => .rock,
            'Y' => .paper,
            'Z' => .scissors,
            else => unreachable,
        };

        score += switch (me) {
            .rock => switch (them) {
                .paper => 1 + 0,
                .rock => 1 + 3,
                .scissors => 1 + 6,
            },
            .paper => switch (them) {
                .scissors => 2 + 0,
                .paper => 2 + 3,
                .rock => 2 + 6,
            },
            .scissors => switch (them) {
                .rock => 3 + 0,
                .scissors => 3 + 3,
                .paper => 3 + 6,
            },
        };
    }

    std.debug.print("score: {}\n", .{score});
}
