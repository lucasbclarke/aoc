const std = @import("std");
const print = @import("std").debug.print;
var i: usize = 0;
var b = undefined;
var red_max: u8 = 12;
var green_max: u8 = 13;
var blue_max: u8 = 14;
var line_number: u32 = 1;
var number_of_games: u32 = 0;
var game_works: bool = false;
var working_ids: u32 = 0;

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
                            if (number > red_max) {
                                print("round not possible\n", .{});
                                game_works = false;
                                //break;
                            } else {
                                print("round possible\n", .{});
                                if (game_works == true) {
                                    print("round already works\n", .{});
                                }
                            }
                            print("line number = {d}\n", .{line_number});
                        },
                        'g' => {
                            if (found_colour == true) {
                                continue;
                            }
                            print("green\n", .{});
                            found_colour = true;
                            found_num_colour = true;
                            if (number > green_max) {
                                print("round not possible\n", .{});
                                game_works = false;
                                //break;
                            } else {
                                print("round possible\n", .{});
                                if (game_works == true) {
                                    print("game already works\n", .{});
                                }
                            }
                            print("line number = {d}\n", .{line_number});
                        },
                        'b' => {
                            if (found_colour == true) {
                                continue;
                            }
                            print("blue\n", .{});
                            found_colour = true;
                            found_num_colour = true;
                            if (number > blue_max) {
                                print("round not possible\n", .{});
                                game_works = false;
                                //break;
                            } else {
                                print("round possible\n", .{});
                                if (game_works == true) {
                                    print("game already works\n", .{});
                                }
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
                            if (game_works == true) {
                                print("game works {d} {d}\n", .{working_ids, line_number});
                                working_ids += line_number;
                            }
                            number = 0;
                            search_mode = state.start;
                            end_of_game = true;
                            line_number += 1;
                            print("line number = {d}\n", .{line_number});
                            print("\n", .{});
                            found_num_colour = false;
                        },
                        //':' => {
                        //    if (game_works == true) {
                        //        print("game works {d} {d}\n", .{working_ids, line_number});
                        //        working_ids += line_number;
                        //    }
                        //    game_works = true;
                        //    number = 0;
                        //    search_mode = state.looking_for_number;
                        //    end_of_game = true;
                        //    line_number += 1;
                        //    print("line number = {d}\n", .{line_number});
                        //    print("\n", .{});
                        //    found_num_colour = false;
                        //},
                        else => {
                            //print("undefined\n", .{});
                        }
                    }

                    if (end_of_game == false) {
                        if (game_works == true) {
                            if (found_num_colour == true) {
                                //print("game works {d} {d}\n", .{working_ids, line_number});
                                //working_ids += line_number;
                                //found_num_colour = false;
                            }
                        }
                    }

                    if (end_of_game == true) {
                        print("number_of_games ={d}\n", .{number_of_games});
                        print("working id's = {d}\n", .{working_ids});
                        break;
                    }

                }
            }
        }
    }
}
