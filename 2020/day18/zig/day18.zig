const std = @import("std");

const Allocator = std.mem.Allocator;

const print = std.debug.print;

const file = @embedFile("../input.txt");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const output = part1(&gpa.allocator, file);
    print("total: {}\n", .{output});
}

const Operator = enum {
    add,
    multiply,
    left_paren,
};

const Token = union(enum) {
    number: u8,
    operator: Operator,
};

fn part1(allocator: *Allocator, contents: []const u8) !u64 {
    var sum: u64 = 0;

    var line_iterator = std.mem.tokenize(contents, "\n");
    while (line_iterator.next()) |line| {
        var output = std.fifo.LinearFifo(Token, .Dynamic).init(allocator);
        defer output.deinit();

        var operator_stack = std.ArrayList(Operator).init(allocator);
        defer operator_stack.deinit();

        for (line) |char| {
            switch (char) {
                '0'...'9' => {
                    try output.writeItem(.{ .number = char - '0' });
                },
                '+', '*' => {
                    while (operator_stack.items.len > 0 and operator_stack.items[operator_stack.items.len - 1] != .left_paren) {
                        try output.writeItem(.{ .operator = operator_stack.pop() });
                    }

                    const op = if (char == '+') Operator.add else Operator.multiply;
                    try operator_stack.append(op);
                },
                '(' => {
                    try operator_stack.append(.left_paren);
                },
                ')' => {
                    while (operator_stack.items.len > 0 and operator_stack.items[operator_stack.items.len - 1] != .left_paren) {
                        try output.writeItem(.{ .operator = operator_stack.pop() });
                    }
                    if (operator_stack.items.len > 0 and operator_stack.items[operator_stack.items.len - 1] == .left_paren) {
                        _ = operator_stack.pop();
                    }
                },
                else => {},
            }
        }

        while (operator_stack.popOrNull()) |token| try output.writeItem(.{ .operator = token });

        var stack = std.ArrayList(u64).init(allocator);
        defer stack.deinit();

        while (output.readItem()) |token| {
            switch (token) {
                .number => |num| try stack.append(num),
                .operator => |op| {
                    var first = stack.pop();
                    var second = stack.pop();
                    switch (op) {
                        .add => try stack.append(first + second),
                        .multiply => try stack.append(first * second),
                        .left_paren => unreachable,
                    }
                },
            }
        }
        std.debug.assert(stack.items.len == 1);
        sum += stack.pop();
    }
    return sum;
}

const testing = std.testing;

test "test strings" {
    const alloc = testing.allocator;

    testing.expectEqual(@intCast(u64, 71), try part1(alloc, "1 + 2 * 3 + 4 * 5 + 6"));
    testing.expectEqual(@intCast(u64, 51), try part1(alloc, "1 + (2 * 3) + (4 * (5 + 6))"));
    testing.expectEqual(@intCast(u64, 26), try part1(alloc, "2 * 3 + (4 * 5)"));
    testing.expectEqual(@intCast(u64, 437), try part1(alloc, "5 + (8 * 3 + 9 + 3 * 4 * 3)"));
    testing.expectEqual(@intCast(u64, 12240), try part1(alloc, "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))"));
    testing.expectEqual(@intCast(u64, 13632), try part1(alloc, "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"));
}
