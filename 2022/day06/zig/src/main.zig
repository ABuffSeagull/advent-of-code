const std = @import("std");

pub fn main() !void {
    const input = @embedFile("./input.txt");

    std.debug.print("part1: {}, part2: {}\n", .{
        findMarker(4, input),
        findMarker(14, input),
    });
}

fn findMarker(comptime window_size: usize, input: []const u8) usize {
    var index: usize = 0;
    while (index + window_size < input.len) : (index += 1) {
        // fill in SIMD vector
        const chars: @Vector(window_size, u8) = input[index..][0..window_size].*;
        // change from ascii to letter position, to save some bits
        const offsets = chars - @splat(window_size, @as(u8, 'a'));
        // change from offsets value to bit position
        const bit_set = @splat(window_size, @as(u32, 1)) << @truncate(u5, offsets);
        // count how many bits are set
        if (@popCount(@reduce(.Or, bit_set)) == window_size) {
            return index + window_size;
        }
    }
    unreachable;
}
