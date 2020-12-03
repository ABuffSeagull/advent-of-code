const std = @import("std");

const file = @embedFile("../input.txt");

pub fn main() void {
    var floor: isize = 0;
    var found = false;
    for (file) |char, index| {
        switch (char) {
            '(' => floor += 1,
            ')' => floor -= 1,
            else => {},
        }
        if (!found and floor == -1) {
            found = true;
            std.debug.print("basement at position {}\n", .{index + 1});
        }
    }
    std.debug.print("final floor: {}\n", .{floor});
}
