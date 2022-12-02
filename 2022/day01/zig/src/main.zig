const std = @import("std");

pub fn main() !void {
    var most_calories: usize = 0;

    var input_buffer = [_]u8{undefined} ** (1024 * 1024);

    const input = try std.fs.cwd().readFile("../input.txt", &input_buffer);

    var elf_it = std.mem.split(u8, input, "\n\n");

    while (elf_it.next()) |elf| {
        var elf_calories: usize = 0;

        var food_it = std.mem.tokenize(u8, elf, "\n");
        while (food_it.next()) |food| {
            elf_calories += try std.fmt.parseUnsigned(usize, food, 10);
        }

        most_calories = std.math.max(elf_calories, most_calories);
    }

    std.debug.print("most: {}\n", .{most_calories});
}
