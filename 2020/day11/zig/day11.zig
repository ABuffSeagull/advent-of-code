const std = @import("std");
const mem = std.mem;
const print = std.debug.print;

const file = @embedFile("../input.txt");

const CellState = enum {
    floor,
    occupied,
    empty,
};

var row_length: usize = undefined;

var last_map: []CellState = undefined;
var current_map: []CellState = undefined;

const Coord = struct {
    row: isize,
    column: isize,
    pub fn toIndex(self: *const Coord) isize {
        return self.row * @intCast(isize, row_length) + self.column;
    }
};

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var allocator = &arena.allocator;

    row_length = mem.indexOf(u8, file, "\n").?;

    var array_list = try std.ArrayList(CellState).initCapacity(allocator, row_length * row_length);

    for (file) |char| {
        switch (char) {
            'L' => {
                try array_list.append(.empty);
            },
            '#' => {
                try array_list.append(.occupied);
            },
            '.' => {
                try array_list.append(.floor);
            },
            else => {},
        }
    }

    current_map = array_list.toOwnedSlice();

    last_map = try allocator.alloc(CellState, current_map.len);
    mem.set(CellState, last_map, .empty);

    while (!mem.eql(CellState, last_map, current_map)) {
        mem.copy(CellState, last_map, current_map);

        for (current_map) |*cell, index| {
            const isize_length = @intCast(isize, row_length);
            const row = @intCast(isize, index / row_length);
            const column = @intCast(isize, index % row_length);
            const check_coords = [_]Coord{
                .{ .row = row - 1, .column = column - 1 },
                .{ .row = row - 1, .column = column },
                .{ .row = row - 1, .column = column + 1 },
                .{ .row = row, .column = column - 1 },
                .{ .row = row, .column = column + 1 },
                .{ .row = row + 1, .column = column - 1 },
                .{ .row = row + 1, .column = column },
                .{ .row = row + 1, .column = column + 1 },
            };

            var occupied_seats: usize = 0;

            for (check_coords) |coord| {
                const other_cell = sliceGet(CellState, last_map, coord);
                if (other_cell != null and other_cell.? == .occupied) {
                    occupied_seats += 1;
                }
            }

            if (cell.* == .empty and occupied_seats == 0) {
                cell.* = .occupied;
            } else if (cell.* == .occupied and occupied_seats >= 4) {
                cell.* = .empty;
            }
        }
    }

    var occupied_seats: usize = 0;
    for (current_map) |cell| {
        if (cell == .occupied) occupied_seats += 1;
    }

    print("occupied seats: {}\n", .{occupied_seats});
}

fn sliceGet(comptime T: type, slice: []T, coord: Coord) ?T {
    return if (coord.row >= 0 and coord.row < row_length and coord.column >= 0 and coord.column < row_length)
        slice[@intCast(usize, coord.toIndex())]
    else
        null;
}

fn printMap(map: []CellState) void {
    for (map) |cell, index| {
        const cell_display: u8 = switch (cell) {
            .occupied => '#',
            .empty => 'L',
            .floor => '.',
        };
        print("{c}", .{cell_display});
        if (index % row_length == row_length - 1) print("\n", .{});
    }
}
