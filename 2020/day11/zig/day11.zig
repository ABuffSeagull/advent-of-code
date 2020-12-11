const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;
const print = std.debug.print;

const file = @embedFile("../input.txt");

const CellState = enum {
    floor,
    occupied,
    empty,
};

var row_length: usize = undefined;

const Coord = struct {
    row: i64,
    column: i64,
    pub fn toIndex(self: *const Coord) usize {
        return @intCast(usize, self.row * @intCast(i64, row_length) + self.column);
    }
    pub fn fromIndex(index: usize) Coord {
        return .{
            .row = @intCast(i64, index / row_length),
            .column = @intCast(i64, index % row_length),
        };
    }
};

pub fn main() !void {
    // Make a memory allocator
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    var allocator = &arena.allocator;

    // Find how long a row is
    row_length = mem.indexOf(u8, file, "\n").?;

    // Parse the input into an array of CellStates
    const input_map = try parseInput(allocator, file);

    // Duplicate the map into a new array
    var current_map = try allocator.dupe(CellState, input_map);
    // Allocate and "zero out", another copy
    var last_map = try allocator.alloc(CellState, input_map.len);
    mem.set(CellState, last_map, .floor);

    // Run part 1
    const occupied_1 = part1(last_map, current_map);

    // Reset the arrays
    mem.copy(CellState, current_map, input_map);
    mem.set(CellState, last_map, .floor);

    // Run part 2
    const occupied_2 = part2(last_map, current_map);

    print("Part 1: {}, Part 2: {}\n", .{ occupied_1, occupied_2 });
}

pub fn part1(last_map: []CellState, current_map: []CellState) usize {
    // While the map is not the same as the last one
    while (!mem.eql(CellState, last_map, current_map)) {
        // Overwrite the last map with the current one
        mem.copy(CellState, last_map, current_map);

        // Update each cell with the rules
        for (current_map) |*cell, index| {
            // Make a coordinate for the current index
            const coord = Coord.fromIndex(index);
            // Make a list of coordinates for the adjacent cells
            const check_coords = [_]Coord{
                .{ .row = coord.row - 1, .column = coord.column - 1 },
                .{ .row = coord.row - 1, .column = coord.column },
                .{ .row = coord.row - 1, .column = coord.column + 1 },
                .{ .row = coord.row, .column = coord.column - 1 },
                .{ .row = coord.row, .column = coord.column + 1 },
                .{ .row = coord.row + 1, .column = coord.column - 1 },
                .{ .row = coord.row + 1, .column = coord.column },
                .{ .row = coord.row + 1, .column = coord.column + 1 },
            };

            // Count all occupied seats
            var occupied_seats: usize = 0;
            for (check_coords) |check_coord| {
                // Get the possible cell for the given coord
                const other_cell = cellGet(last_map, check_coord);
                // If it's occupied, add it to the count
                if (other_cell != null and other_cell.? == .occupied) {
                    occupied_seats += 1;
                }
            }

            // Apply the rules given
            if (cell.* == .empty and occupied_seats == 0) {
                cell.* = .occupied;
            } else if (cell.* == .occupied and occupied_seats >= 4) {
                cell.* = .empty;
            }
        }
    }

    // Count all occupied seats in the full map
    var occupied_seats: usize = 0;
    for (current_map) |cell| {
        if (cell == .occupied) occupied_seats += 1;
    }

    return occupied_seats;
}

pub fn part2(last_map: []CellState, current_map: []CellState) usize {
    // While the map is not the same as the last one
    while (!mem.eql(CellState, last_map, current_map)) {
        // Overwrite the last map with the current one
        mem.copy(CellState, last_map, current_map);

        // Update each cell with the rules
        for (current_map) |*cell, index| {
            // Make a coordinate for the current index
            const check_coord = Coord.fromIndex(index);

            // Make a list of possible cell states for each direction
            const first_seats = [_]?CellState{
                checkDirection(last_map, check_coord, -1, -1),
                checkDirection(last_map, check_coord, -1, 0),
                checkDirection(last_map, check_coord, -1, 1),
                checkDirection(last_map, check_coord, 0, -1),
                checkDirection(last_map, check_coord, 0, 1),
                checkDirection(last_map, check_coord, 1, -1),
                checkDirection(last_map, check_coord, 1, 0),
                checkDirection(last_map, check_coord, 1, 1),
            };

            // Count all the occupied seats
            var occupied_seats: usize = 0;
            for (first_seats) |seat| {
                if (seat != null and seat.? == .occupied) {
                    occupied_seats += 1;
                }
            }

            // Apply the given rules
            if (cell.* == .empty and occupied_seats == 0) {
                cell.* = .occupied;
            } else if (cell.* == .occupied and occupied_seats >= 5) {
                cell.* = .empty;
            }
        }
    }

    // Count all the occupied seats for the full map
    var occupied_seats: usize = 0;
    for (current_map) |cell| {
        if (cell == .occupied) occupied_seats += 1;
    }

    return occupied_seats;
}

/// Parse the given string into a list of CellStates
fn parseInput(allocator: *Allocator, input: []const u8) ![]CellState {
    // Init an array list with probably the correct capacity
    var array_list = try std.ArrayList(CellState).initCapacity(allocator, row_length * row_length);

    // Append the correct enum values, skipping newlines
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

    // Return the actual slice, not an array list
    return array_list.toOwnedSlice();
}

/// Given a coord, get the cell if it's within bounds, otherwise null
fn cellGet(slice: []const CellState, coord: Coord) ?CellState {
    return if (coord.row >= 0 and coord.row < row_length and coord.column >= 0 and coord.column < row_length)
        slice[coord.toIndex()]
    else
        null;
}

/// Repeatedly check in a given direction until you find something that's not the floor (aka, Chair or null)
fn checkDirection(map: []const CellState, start: Coord, row_change: i8, column_change: i8) ?CellState {
    // Move once in the direction
    var coord = .{ .row = start.row + row_change, .column = start.column + column_change };
    // While we keep getting non-null values
    while (cellGet(map, coord)) |cell| {
        if (cell != .floor) return cell;
        coord = .{ .row = coord.row + row_change, .column = coord.column + column_change };
    }
    return null;
}

/// More for debug, print out the current map
fn printMap(map: []const CellState) void {
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
