const std = @import("std");

const Option = enum(u8) {
    rock = 1,
    paper = 2,
    scissors = 3,
};

pub fn main() !void {
    var input_buffer = [_]u8{undefined} ** (1024 * 1024);

    const input = try std.fs.cwd().readFile("../input.txt", &input_buffer);

    part1(input);
    part2(input);
}

pub fn part1(input: []const u8) void {
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

        score += @enumToInt(me);

        score += switch (me) {
            .rock => switch (them) {
                .paper => @enumToInt(Outcome.lose),
                .rock => @enumToInt(Outcome.draw),
                .scissors => @enumToInt(Outcome.win),
            },
            .paper => switch (them) {
                .scissors => @enumToInt(Outcome.lose),
                .paper => @enumToInt(Outcome.draw),
                .rock => @enumToInt(Outcome.win),
            },
            .scissors => switch (them) {
                .rock => @enumToInt(Outcome.lose),
                .scissors => @enumToInt(Outcome.draw),
                .paper => @enumToInt(Outcome.win),
            },
        };
    }

    std.debug.print("score: {}\n", .{score});
}

const Outcome = enum(u8) {
    win = 6,
    lose = 0,
    draw = 3,
};

pub fn part2(input: []const u8) void {
    var line_it = std.mem.tokenize(u8, input, "\n");

    var score: usize = 0;
    while (line_it.next()) |line| {
        const them: Option = switch (line[0]) {
            'A' => .rock,
            'B' => .paper,
            'C' => .scissors,
            else => unreachable,
        };
        const desired_outcome: Outcome = switch (line[2]) {
            'X' => .lose,
            'Y' => .draw,
            'Z' => .win,
            else => unreachable,
        };

        score += @enumToInt(desired_outcome);

        score += switch (desired_outcome) {
            .win => switch (them) {
                .paper => @enumToInt(Option.scissors),
                .rock => @enumToInt(Option.paper),
                .scissors => @enumToInt(Option.rock),
            },
            .lose => switch (them) {
                .paper => @enumToInt(Option.rock),
                .rock => @enumToInt(Option.scissors),
                .scissors => @enumToInt(Option.paper),
            },
            .draw => switch (them) {
                .paper => @enumToInt(them),
                .rock => @enumToInt(them),
                .scissors => @enumToInt(them),
            },
        };
    }

    std.debug.print("score: {}\n", .{score});
}
