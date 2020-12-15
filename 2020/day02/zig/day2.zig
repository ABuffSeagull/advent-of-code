const std = @import("std");
const heap = std.heap;
const mem = std.mem;
const fmt = std.fmt;
const print = std.debug.print;

const file = @embedFile("../input.txt");

const PasswordEntry = struct {
    first_num: u32,
    second_num: u32,
    letter: u8,
    password: []const u8,
};

pub fn main() !void {
    // Once again, hard coding the size cause I'm cheating
    var passwords: [1000]PasswordEntry = undefined;

    var token_iterator = mem.tokenize(file, "\n");
    var index: usize = 0;
    while (token_iterator.next()) |token| {
        // This honestly feels like a weird way to do it
        // Basically we're breaking the line on any of the given characters
        var line_iterator = mem.tokenize(token, "-: ");
        const first_string = line_iterator.next().?;
        const second_string = line_iterator.next().?;
        const letter_string = line_iterator.next().?;
        const password_string = line_iterator.next().?;
        passwords[index] = .{
            .first_num = try fmt.parseUnsigned(u32, first_string, 10),
            .second_num = try fmt.parseUnsigned(u32, second_string, 10),
            .letter = letter_string[0],
            .password = password_string,
        };
        index += 1;
    }

    part1(&passwords);
    part2(&passwords);
}

fn part1(passwords: []PasswordEntry) void {
    var valid_count: usize = 0;
    for (passwords) |entry| {
        var letter_count: usize = 0;
        for (entry.password) |char| {
            if (char == entry.letter) letter_count += 1;
        }

        if (letter_count >= entry.first_num and letter_count <= entry.second_num) {
            valid_count += 1;
        }
    }
    print("part 1 valid passwords: {}\n", .{valid_count});
}

fn part2(passwords: []PasswordEntry) void {
    var valid_count: usize = 0;
    for (passwords) |entry| {
        const is_first_position = entry.password[entry.first_num - 1] == entry.letter;
        const is_second_position = entry.password[entry.second_num - 1] == entry.letter;

        if ((is_first_position or is_second_position) and !(is_first_position and is_second_position)) {
            valid_count += 1;
        }
    }
    print("part 2 valid passwords: {}\n", .{valid_count});
}
