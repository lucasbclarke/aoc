const std = @import("std");
const print = @import("std").debug.print;

var is_symbol: bool = false;
var is_num: bool = false;
var number: u32 = 0;
var per_line_counter: u8 = 0;
var line_num: u8 = 1;
var index: u16 = 0;
var result: u32 = 0;

var gpa = std.heap.GeneralPurposeAllocator(.{}){};
var sym_arr = std.ArrayList(@Vector(2, u8)).init(gpa.allocator());

pub fn sym_check(x: u8, y: u8) !bool {
    print("debug\n", .{});
    for (sym_arr.items[0..]) |capture| {
        for ( 0 .. 3) |ix| {
            for ( 0 .. 3) |iy| {
                if (capture[0] + 1 == ix + x and capture[1] + 1 == iy + y) {
                  print("true\n", .{});
                  return true;
                }
            }
        }
    }
    return false;
}

pub fn main() !void{
    defer sym_arr.deinit();
    defer _ = gpa.deinit();

    const file = try std.fs.cwd().openFile("s", .{});
    defer file.close();
    
    var buf_reader = std.io.bufferedReader(file.reader());
    var reader = buf_reader.reader();

    while (true) {
        per_line_counter += 1;
        is_symbol = false;

        var read_byte: u8 = 0;

        if (reader.readByte()) |byte| {
            print("read_byte ={c}\n", .{byte});
            read_byte = byte;
        } else |err| {
            print("Error: {any}\n", .{err});
            break; 
        }
        
        switch (read_byte) {
            '%' => { is_symbol = true; number = 0; try sym_arr.append(@Vector(2, u8){per_line_counter, line_num}); },
            '/' => { is_symbol = true; number = 0; try sym_arr.append(@Vector(2, u8){per_line_counter, line_num}); },
            '#' => { is_symbol = true; number = 0; try sym_arr.append(@Vector(2, u8){per_line_counter, line_num}); },
            '$' => { is_symbol = true; number = 0; try sym_arr.append(@Vector(2, u8){per_line_counter, line_num}); },
            '*' => { is_symbol = true; number = 0; try sym_arr.append(@Vector(2, u8){per_line_counter, line_num}); },
            '=' => { is_symbol = true; number = 0; try sym_arr.append(@Vector(2, u8){per_line_counter, line_num}); },
            '@' => { is_symbol = true; number = 0; try sym_arr.append(@Vector(2, u8){per_line_counter, line_num}); },
            '+' => { is_symbol = true; number = 0; try sym_arr.append(@Vector(2, u8){per_line_counter, line_num}); },
            '&' => { is_symbol = true; number = 0; try sym_arr.append(@Vector(2, u8){per_line_counter, line_num}); },
            '-' => { is_symbol = true; number = 0; try sym_arr.append(@Vector(2, u8){per_line_counter, line_num}); },
            '\n' => { per_line_counter = 0; line_num += 1; },
            else => {}
        }

        if(is_symbol == true) {
            print("found Symbol\n", .{});
        }
        print("per_line_counter = {}\n", .{per_line_counter});
        print("sym_arr = {d}\n", .{sym_arr.items[0..]});
        
    }
    
    try file.seekTo(0);
    
    line_num = 1;
    var is_part_num = false;
    while(true) {
        index += 1;
        //is_part_num = false;
        var num_finished = false;

        const read_byte2 = try reader.readByte();
        print("read_byte ={c}\n", .{read_byte2});

        switch (read_byte2) {
            '0' => {
                is_num = true;
                number = (number * 10);
                if (is_part_num != true) {
                    is_part_num = try sym_check(per_line_counter, line_num);
                } else {
                  print("is already a part number\n", .{});
                }

            },
            '1' => {
                is_num = true;
                number = (number * 10) + 1;
                if (is_part_num != true) {
                    is_part_num = try sym_check(per_line_counter, line_num);
                } else {
                  print("is already a part number\n", .{});
                }

            },
            '2' => {
                is_num = true;
                number = (number * 10) + 2;
                if (is_part_num != true) {
                    is_part_num = try sym_check(per_line_counter, line_num);
                } else {
                  print("is already a part number\n", .{});
                }
            },
            '3' => {
                is_num = true;
                number = (number * 10) + 3;
                if (is_part_num != true) {
                    is_part_num = try sym_check(per_line_counter, line_num);
                } else {
                  print("is already a part number\n", .{});
                }

            },
            '4' => {
                is_num = true;
                number = (number * 10) + 4;
                if (is_part_num != true) {
                    is_part_num = try sym_check(per_line_counter, line_num);
                } else {
                  print("is already a part number\n", .{});
                }

            },
            '5' => {
                is_num = true;
                number = (number * 10) + 5;
                if (is_part_num != true) {
                    is_part_num = try sym_check(per_line_counter, line_num);
                } else {
                  print("is already a part number\n", .{});
                }

            },
            '6' => {
                is_num = true;
                number = (number * 10) + 6;
                if (is_part_num != true) {
                    is_part_num = try sym_check(per_line_counter, line_num);
                } else {
                  print("is already a part number\n", .{});
                }

            },
            '7' => {
                is_num = true;
                number = (number * 10) + 7;
                if (is_part_num != true) {
                    is_part_num = try sym_check(per_line_counter, line_num);
                } else {
                  print("is already a part number\n", .{});
                }

            },
            '8' => {
                is_num = true;
                number = (number * 10) + 8;
                if (is_part_num != true) {
                    is_part_num = try sym_check(per_line_counter, line_num);
                } else {
                  print("is already a part number\n", .{});
                }

            },
            '9' => {
                is_num = true;
                number = (number * 10) + 9;
                if (is_part_num != true) {
                    is_part_num = try sym_check(per_line_counter, line_num);
                } else {
                  print("is already a part number\n", .{});
                }
            },
            '\n' => {
                per_line_counter = 0;
                line_num += 1;
                num_finished = true;
            },
            else => {
                num_finished = true;
            },
        }
        per_line_counter += 1;

        if (is_num == true) {
          if (num_finished == true) {
            if(is_part_num == true) {
              print("\n", .{});
              print("part number ={}\n", .{number});
              result += number;
            }
            number = 0;
            is_num = false;
            is_part_num = false;
            print("\n", .{});
            print("result = {}\n", .{result});
            print("\n", .{});

          }
        }
    }
}
