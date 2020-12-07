const std = @import("std");
const md5 = std.crypto.hash.Md5;
const math = std.math;
const mem = std.mem;
const fmt = std.fmt;

const zero_buffer = [_]u8{0} ** 3;
var input_buffer = [_]u8{0} ** 32; // 32 is just a nice number, nothing more than that
var hash_buffer = [_]u8{0} ** md5.digest_length;

const password = "iwrupvqb";

pub fn main() !void {
    var last_timestamp = std.time.timestamp();

    // Zero would throw an error with log10, and honestly it's not gonna be zero
    var index: u64 = 1;

    while (true) : (index += 1) {
        _ = try fmt.bufPrint(&input_buffer, "{}{}", .{ password, index });

        const digits = math.log10(index) + 1;
        const input = input_buffer[0..(password.len + digits)];

        md5.hash(input, &hash_buffer, .{});

        if (mem.eql(u8, &zero_buffer, hash_buffer[0..3])) {
            break;
        }
    }

    std.debug.print("index: {}, hash: {x}\n", .{ index, hash_buffer });
}
