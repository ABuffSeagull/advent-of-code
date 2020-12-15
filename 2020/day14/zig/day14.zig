const std = @import("std");
const mem = std.mem;

const file = @embedFile("../input.txt");
//     \\mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
//     \\mem[8] = 11
//     \\mem[7] = 101
//     \\mem[8] = 0
// ;

const Mask = struct {
    and_mask: u64,
    or_mask: u64,
};

const Memory = struct {
    address: u64,
    value: u64,
};

const Instruction = union(enum) {
    set_mask: Mask,
    set_memory: Memory,
};

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var allocator = &arena.allocator;

    var instructions = std.ArrayList(Instruction).init(allocator);
    defer instructions.deinit();

    var line_iterator = mem.tokenize(file, "\n");
    while (line_iterator.next()) |line| {
        if (mem.startsWith(u8, line, "mem")) {
            const end_of_address = mem.indexOf(u8, line, "]").?;
            const start_of_value = mem.lastIndexOf(u8, line, " ").? + 1;
            try instructions.append(.{
                .set_memory = .{
                    .address = try std.fmt.parseUnsigned(u64, line[4..end_of_address], 10),
                    .value = try std.fmt.parseUnsigned(u64, line[start_of_value..], 10),
                },
            });
        } else {
            var mask = Mask{ .and_mask = 0, .or_mask = 0 };
            var index: usize = 0;
            for (line[7..]) |char| {
                switch (char) {
                    '1' => mask.or_mask |= 1,
                    '0' => mask.and_mask |= 1,
                    else => {},
                }
                mask.or_mask <<= 1;
                mask.and_mask <<= 1;
            }
            // undo the last shift
            mask.or_mask >>= 1;
            mask.and_mask >>= 1;
            mask.and_mask = ~mask.and_mask;
            try instructions.append(.{ .set_mask = mask });
        }
    }

    var memory_map = std.AutoHashMap(u64, u64).init(allocator);
    defer memory_map.deinit();

    var last_mask: Mask = undefined;
    for (instructions.items) |instruction| {
        switch (instruction) {
            .set_mask => |mask| last_mask = mask,
            .set_memory => |memory| {
                // std.debug.print("value: {}, after or: {}, after and:
                try memory_map.put(memory.address, (memory.value | last_mask.or_mask) & last_mask.and_mask);
            },
        }
    }

    var sum: u64 = 0;
    var memory_iter = memory_map.iterator();
    while (memory_iter.next()) |entry| {
        sum += entry.value;
    }
    std.debug.print("{}\n", .{sum});
}
