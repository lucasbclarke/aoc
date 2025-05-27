const std = @import("std");
const print = @import("std").debug.print;
var i: usize = 0;
var b = undefined;
var red_min: u8 = undefined;
var green_min: u8 = undefined;
var blue_min: u8 = undefined;
var number_of_games: u32 = 0;
var game_works: bool = false;
var power_each_line: u32 = undefined;
var total_power: u32 = undefined;
var blue_min_red_min: u32 = undefined;

const state = enum {
    start,
    looking_for_number,
    looking_for_colour,
};

pub fn main() !void {
    var found_num_colour: bool = false;
    var number: u8 = 0;
    var search_mode: state = state.start;
    var file = try std.fs.cwd().openFile("s", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    while (true) {
        var buf: [2048]u8 = undefined;
        switch (search_mode) {
            state.start => {
                number_of_games += 1;
                _ = try in_stream.readUntilDelimiterOrEof(buf[0..], ':');
                print("new game\n", .{});
                game_works = true;
                search_mode = state.looking_for_number;
            },
            state.looking_for_number => { 
                found_num_colour = false;
                _ = try in_stream.readUntilDelimiterOrEof(buf[0..], ' ');
                var found_game: bool = false;
                for (buf) |d| {
                    switch (d) {
                        '0' => { found_game = true; number = ( number * 10); },
                        '1' => { found_game = true; number = ( number * 10) + 1; },
                        '2' => { found_game = true; number = ( number * 10) + 2; },
                        '3' => { found_game = true; number = ( number * 10) + 3; },
                        '4' => { found_game = true; number = ( number * 10) + 4; },
                        '5' => { found_game = true; number = ( number * 10) + 5; },
                        '6' => { found_game = true; number = ( number * 10) + 6; },
                        '7' => { found_game = true; number = ( number * 10) + 7; },
                        '8' => { found_game = true; number = ( number * 10) + 8; },
                        '9' => { found_game = true; number = ( number * 10) + 9; },
                        ' ' => {
                            if (found_game == true) {
                                search_mode = state.looking_for_colour;
                            }
                            print("number = {d}\n", .{number});
                        },
                        else => {
                            //print("{c}\n", .{d});
                        }
                    }

                }
            },

            state.looking_for_colour => {
                _ = try in_stream.readUntilDelimiterOrEof(buf[0..], ' ');
                var found_colour: bool = false;
                var end_of_round: bool = false;
                var end_of_game: bool = false;
                for (buf) |j| {
                    switch (j) {
                        'r' => {
                            if (found_colour == true) {
                                continue;
                            }
                            print("red\n", .{});
                            found_colour = true;
                            found_num_colour = true;
                            if (number > red_min) {
                                red_min = number;
                                print("red minimum = {d}\n", .{red_min});
                            } 
                        },
                        'g' => {
                            if (found_colour == true) {
                                continue;
                            }
                            print("green\n", .{});
                            found_colour = true;
                            found_num_colour = true;
                            if (number > green_min) {
                                green_min = number;
                                print("green minimum = {d}\n", .{green_min});
                            }
                        },
                        'b' => {
                            if (found_colour == true) {
                                continue;
                            }
                            print("blue\n", .{});
                            found_colour = true;
                            found_num_colour = true;
                            if (number > blue_min) {
                                blue_min = number;
                                print("blue minimum = {d}\n", .{blue_min});
                            }
                        },
                        ' ' => {
                            number = 0;
                            if (found_colour == true) {
                                search_mode = state.looking_for_number;
                            }
                        },
                        ';' => {
                            end_of_round = true;
                            print("end of round\n", .{});
                            search_mode = state.looking_for_number;
                            print(";", .{});
                            print("\n", .{});
                        },
                        '\n' => {
                            blue_min_red_min = try std.math.mul(u32, blue_min, red_min);
                            power_each_line = try std.math.mul(u32, blue_min_red_min, green_min);
                            print("power each line ={d}\n", .{power_each_line});
                            total_power += power_each_line;
                            number = 0;
                            green_min = 0;
                            red_min = 0;
                            blue_min = 0;
                            power_each_line = 0;
                            search_mode = state.start;
                            end_of_game = true;
                            print("\n", .{});
                            found_num_colour = false;
                        },
                        
                        else => {}
                    }

                    if (end_of_game == true) {
                        print("number_of_games ={d}\n", .{number_of_games});
                        print("total power = {d}\n", .{total_power});
                        break;
                    }

                }
            }
        }
    }
}
