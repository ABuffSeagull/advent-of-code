const std = @import("std");

// heh, good pun
const AlphaBitSet = std.StaticBitSet(26 * 2);

pub fn main() !void {
    var input_buffer = [_]u8{undefined} ** (1024 * 1024);

    const input = try std.fs.cwd().readFile("../input.txt", &input_buffer);

    part1(input);
    part2(input);
}

fn part1(input: []const u8) void {
    var line_it = std.mem.tokenize(u8, input, "\n");

    var priority_sum: usize = 0;
    while (line_it.next()) |line| {
        var first_set = AlphaBitSet.initEmpty();
        // first compartment
        for (line[0 .. line.len / 2]) |char| {
            if (char < 'a') {
                first_set.set(char - 'A' + 26);
            } else {
                first_set.set(char - 'a');
            }
        }
        var second_set = AlphaBitSet.initEmpty();
        // second compartment
        for (line[line.len / 2 ..]) |char| {
            if (char < 'a') {
                second_set.set(char - 'A' + 26);
            } else {
                second_set.set(char - 'a');
            }
        }

        first_set.setIntersection(second_set);
        priority_sum += first_set.findFirstSet().? + 1;
    }

    std.debug.print("part1: {}\n", .{priority_sum});
}

fn part2(input: []const u8) void {
    var line_it = std.mem.tokenize(u8, input, "\n");

    var priority_sum: usize = 0;
    while (line_it.next()) |first_line| {
        var first_set = AlphaBitSet.initEmpty();
        for (first_line) |char| {
            if (char < 'a') {
                first_set.set(char - 'A' + 26);
            } else {
                first_set.set(char - 'a');
            }
        }

        var second_set = AlphaBitSet.initEmpty();
        for (line_it.next().?) |char| {
            if (char < 'a') {
                second_set.set(char - 'A' + 26);
            } else {
                second_set.set(char - 'a');
            }
        }

        var third_set = AlphaBitSet.initEmpty();
        for (line_it.next().?) |char| {
            if (char < 'a') {
                third_set.set(char - 'A' + 26);
            } else {
                third_set.set(char - 'a');
            }
        }

        first_set.setIntersection(second_set);
        first_set.setIntersection(third_set);

        priority_sum += first_set.findFirstSet().? + 1;
    }

    std.debug.print("part2: {}\n", .{priority_sum});
}
