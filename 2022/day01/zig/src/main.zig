const std = @import("std");

pub fn main() !void {
    var input_buffer = [_]u8{undefined} ** (1024 * 1024);

    const input = try std.fs.cwd().readFile("../input.txt", &input_buffer);

    try part1(input);

    try part2(input);
}

fn part1(input: []const u8) !void {
    var most_calories: usize = 0;

    var elf_it = std.mem.split(u8, input, "\n\n");

    while (elf_it.next()) |elf| {
        var elf_calories: usize = 0;

        var food_it = std.mem.tokenize(u8, elf, "\n");
        while (food_it.next()) |food| {
            elf_calories += try std.fmt.parseUnsigned(usize, food, 10);
        }

        most_calories = std.math.max(elf_calories, most_calories);
    }

    std.debug.print("part1 most: {}\n", .{most_calories});
}

fn part2(input: []const u8) !void {
    var top4 = [_]usize{0} ** 4;

    var elf_it = std.mem.split(u8, input, "\n\n");

    while (elf_it.next()) |elf| {
        var elf_calories: usize = 0;

        var food_it = std.mem.tokenize(u8, elf, "\n");
        while (food_it.next()) |food| {
            elf_calories += try std.fmt.parseUnsigned(usize, food, 10);
        }

        top4[3] = elf_calories;
        std.sort.sort(usize, &top4, {}, comptime std.sort.desc(usize));
    }

    var summed: usize = 0;
    for (top4[0..3]) |elf| {
        summed += elf;
    }

    std.debug.print("top 3: {}\n", .{summed});
}
