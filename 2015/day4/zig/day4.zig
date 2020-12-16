const std = @import("std");
const md5 = std.crypto.hash.Md5;
const math = std.math;
const mem = std.mem;
const fmt = std.fmt;
const Thread = std.Thread;

var is_done = false;

const Context = struct {
    total_threads: usize,
    offset: usize,
};

const equal_bytes = 3;

const password = "iwrupvqb";

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var threads = try gpa.allocator.alloc(*Thread, Thread.cpuCount() catch 1);
    defer gpa.allocator.free(threads);

    for (threads) |*thread, index| {
        thread.* = try Thread.spawn(Context{ .total_threads = threads.len, .offset = index + 1 }, run_hashes);
    }

    for (threads) |thread| thread.wait();
}

const zero_buffer = [_]u8{0} ** equal_bytes;
threadlocal var input_buffer = [_]u8{0} ** (1 << 8);
threadlocal var hash_buffer = [_]u8{0} ** md5.digest_length;

fn run_hashes(context: Context) void {
    var index: u64 = context.offset;

    while (true) : (index += context.total_threads) {
        if (is_done) return;

        _ = fmt.bufPrint(&input_buffer, "{}{}", .{ password, index }) catch unreachable;

        const digits = math.log10(index) + 1;
        const input = input_buffer[0..(password.len + digits)];

        md5.hash(input, &hash_buffer, .{});

        if (mem.startsWith(u8, &hash_buffer, &zero_buffer)) break;
    }
    is_done = true;
    std.debug.print("index: {}, hash: {x}\n", .{ index, hash_buffer });
}
