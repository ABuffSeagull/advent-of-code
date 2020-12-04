const std = @import("std");
const tokenize = std.mem.tokenize;
const parseUnsigned = std.fmt.parseUnsigned;
const print = std.debug.print;
const sort = std.sort.insertionSort;

const file = @embedFile("../input.txt");

const asc = std.sort.asc(u32);

pub fn main() !void {
    var total_wrapping_paper: u32 = 0;
    var total_ribbon: u32 = 0;

    var line_iterator = tokenize(file, "\n");
    while (line_iterator.next()) |line| {
        var number_iterator = tokenize(line, "x");
        var nums = [_]u32{
            try parseUnsigned(u32, number_iterator.next().?, 10),
            try parseUnsigned(u32, number_iterator.next().?, 10),
            try parseUnsigned(u32, number_iterator.next().?, 10),
        };
        sort(u32, &nums, {}, asc);

        const minimum = nums[0];
        const second_minimum = nums[1];

        total_wrapping_paper +=
            2 * (
                nums[0] * nums[1] +
                nums[0] * nums[2] +
                nums[1] * nums[2]
            ) +
            minimum * second_minimum;

        total_ribbon +=
             2 * (minimum + second_minimum) +
             nums[0] * nums[1] * nums[2];
    }
    print("total wrapping paper: {} ft\n", .{total_wrapping_paper});
    print("total ribbon: {} ft\n", .{total_ribbon});
}
