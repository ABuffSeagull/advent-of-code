const std = @import("std");

const input = @embedFile("../input.txt");

const Vector = struct {
    x: i64 = 0,
    y: i64 = 0,
    z: i64 = 0,
    w: i64 = 0,
};

const CubeList = std.ArrayList(Vector);

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = &gpa.allocator;

    var activated_cubes = std.AutoHashMap(Vector, u0).init(allocator);
    defer activated_cubes.deinit();

    {
        var row: i64 = 0;
        var column: i64 = 0;
        for (input) |char| {
            switch (char) {
                '#' => {
                    try activated_cubes.put(.{ .y = row, .x = column, .w = 0 }, 0);
                    column += 1;
                },
                '.' => column += 1,
                '\n' => {
                    row += 1;
                    column = 0;
                },
                else => unreachable,
            }
        }
    }

    var min_vector = Vector{
        .x = std.math.maxInt(i64),
        .y = std.math.maxInt(i64),
        .z = std.math.maxInt(i64),
        .w = std.math.maxInt(i64),
    };
    var max_vector = Vector{
        .x = std.math.minInt(i64),
        .y = std.math.minInt(i64),
        .z = std.math.minInt(i64),
        .w = std.math.minInt(i64),
    };

    {
        var iterator = activated_cubes.iterator();
        while (iterator.next()) |entry| {
            const current = entry.key;
            min_vector = .{
                .x = std.math.min(current.x, min_vector.x),
                .y = std.math.min(current.y, min_vector.y),
                .z = std.math.min(current.z, min_vector.z),
                .w = std.math.min(current.w, min_vector.w),
            };
            max_vector = .{
                .x = std.math.max(current.x, max_vector.x),
                .y = std.math.max(current.y, max_vector.y),
                .z = std.math.max(current.z, max_vector.z),
                .w = std.math.max(current.w, max_vector.w),
            };
        }
    }

    var turns: usize = 0;
    while (turns < 6) : (turns += 1) {
        var cubes_to_activate = CubeList.init(allocator);
        defer cubes_to_activate.deinit();
        var cubes_to_deactivate = CubeList.init(allocator);
        defer cubes_to_deactivate.deinit();

        var z_index = min_vector.z - 1;
        while (z_index <= max_vector.z + 1) : (z_index += 1) {
            var y_index = min_vector.y - 1;
            while (y_index <= max_vector.y + 1) : (y_index += 1) {
                var x_index = min_vector.x - 1;
                while (x_index <= max_vector.x + 1) : (x_index += 1) {
                    var w_index = min_vector.w - 1;
                    while (w_index <= max_vector.w + 1) : (w_index += 1) {
                        const coord = Vector{ .z = z_index, .y = y_index, .x = x_index, .w = w_index };
                        var count = getSurroundingCubes(activated_cubes, coord);

                        if (activated_cubes.contains(coord)) {
                            // adding one to the count, as it includes itself
                            if (count != 3 and count != 4) try cubes_to_deactivate.append(coord);
                        } else {
                            if (count == 3) try cubes_to_activate.append(coord);
                        }
                    }
                }
            }
        }
        for (cubes_to_deactivate.items) |coord| {
            _ = activated_cubes.remove(coord);
        }

        for (cubes_to_activate.items) |coord| {
            try activated_cubes.put(coord, 0);
            min_vector = .{
                .x = std.math.min(coord.x, min_vector.x),
                .y = std.math.min(coord.y, min_vector.y),
                .z = std.math.min(coord.z, min_vector.z),
                .w = std.math.min(coord.w, min_vector.w),
            };
            max_vector = .{
                .x = std.math.max(coord.x, max_vector.x),
                .y = std.math.max(coord.y, max_vector.y),
                .z = std.math.max(coord.z, max_vector.z),
                .w = std.math.max(coord.w, max_vector.w),
            };
        }
    }

    std.debug.print("count: {}\n", .{activated_cubes.count()});
}

const offsets = [_]i64{ -1, 0, 1 };

fn getSurroundingCubes(cube_list: std.AutoHashMap(Vector, u0), coord: Vector) usize {
    var activated_count: usize = 0;
    for (offsets) |offset_z| {
        for (offsets) |offset_y| {
            for (offsets) |offset_x| {
                for (offsets) |offset_w| {
                    var check_coord = Vector{
                        .x = coord.x + offset_x,
                        .y = coord.y + offset_y,
                        .z = coord.z + offset_z,
                        .w = coord.w + offset_w,
                    };
                    if (cube_list.contains(check_coord)) activated_count += 1;
                }
            }
        }
    }
    return activated_count;
}
