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

const part_struct = struct {
    part_num: u32,
    part_vector: @Vector(2, u8),

    pub fn create(x: u8, y: u8, part: u32) !part_struct {
          return part_struct {
              .part_vector = @Vector(2, u8){x, y},
              .part_num = part,
          };
    }
};
var part_struct_arr = std.ArrayList(part_struct).init(gpa.allocator());

pub fn sym_check(x: u8, y: u8) !@Vector(2, u8) {
    for (sym_arr.items[0..]) |capture| {
        for ( 0 .. 3) |ix| {
            for ( 0 .. 3) |iy| {
                if (capture[0] + 1 == ix + x and capture[1] + 1 == iy + y) {
                  print("true\n", .{});
                  var ixx: u8 = undefined;
                  var iyy: u8 = undefined;
                  ixx = @intCast(ix + x);
                  iyy = @intCast(iy + y);
                  print("vector = {}\n", .{@Vector(2, u8){ixx, iyy}});
                  return @Vector(2, u8){ixx, iyy};
                }
            }
        }
    }
    return @Vector(2, u8){0, 0};
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
        
    }
    
    try file.seekTo(0);
    
    line_num = 1;
    var is_part_num = false;
    while(true) {
      var sym_result: @Vector(2, u8) = undefined;
        index += 1;
        var num_finished = false;

        const read_byte2 = try reader.readByte();
        print("read_byte ={c}\n", .{read_byte2});

        switch (read_byte2) {
            '0' => {
                is_num = true;
                number = (number * 10);
                if (is_part_num != true) {
                  print("sym result = {}\n", .{sym_result});
                  sym_result = try sym_check(per_line_counter, line_num); 
                  is_part_num = (sym_result[0] > 0) and (sym_result[1] > 0);
                  print("is_part_num = {}\n", .{is_part_num});
                } else {
                }

            },
            '1' => {
                is_num = true;
                number = (number * 10) + 1;
                if (is_part_num != true) {
                  print("sym result = {}\n", .{sym_result});
                  sym_result = try sym_check(per_line_counter, line_num); 
                  is_part_num = (sym_result[0] > 0) and (sym_result[1] > 0);
                  print("is_part_num = {}\n", .{is_part_num});
                } else {
                }

            },
            '2' => {
                is_num = true;
                number = (number * 10) + 2;
                if (is_part_num != true) {
                  print("sym result = {}\n", .{sym_result});
                  sym_result = try sym_check(per_line_counter, line_num); 
                  is_part_num = (sym_result[0] > 0) and (sym_result[1] > 0);
                  print("is_part_num = {}\n", .{is_part_num});
                } else {
                }
            },
            '3' => {
                is_num = true;
                number = (number * 10) + 3;
                if (is_part_num != true) {
                  print("sym result = {}\n", .{sym_result}); 
                  sym_result = try sym_check(per_line_counter, line_num); 
                  is_part_num = (sym_result[0] > 0) and (sym_result[1] > 0);
                  print("is_part_num = {}\n", .{is_part_num});
                } else {
                }
            },
            '4' => {
                is_num = true;
                number = (number * 10) + 4;
                if (is_part_num != true) {
                  print("sym result = {}\n", .{sym_result});
                  sym_result = try sym_check(per_line_counter, line_num); 
                  is_part_num = (sym_result[0] > 0) and (sym_result[1] > 0);
                  print("is_part_num = {}\n", .{is_part_num});
                } else {
                }
            },
            '5' => {
                is_num = true;
                number = (number * 10) + 5;
                if (is_part_num != true) {
                  print("sym result = {}\n", .{sym_result});
                  sym_result = try sym_check(per_line_counter, line_num); 
                  is_part_num = (sym_result[0] > 0) and (sym_result[1] > 0);
                  print("is_part_num = {}\n", .{is_part_num});
                } else {
                }
            },
            '6' => {
                is_num = true;
                number = (number * 10) + 6;
                if (is_part_num != true) {
                  print("sym result = {}\n", .{sym_result});
                  sym_result = try sym_check(per_line_counter, line_num); 
                  is_part_num = (sym_result[0] > 0) and (sym_result[1] > 0);
                  print("is_part_num = {}\n", .{is_part_num});
                } else {
                }

            },
            '7' => {
                is_num = true;
                number = (number * 10) + 7;
                if (is_part_num != true) {
                  print("sym result = {}\n", .{sym_result});
                  sym_result = try sym_check(per_line_counter, line_num); 
                  is_part_num = (sym_result[0] > 0) and (sym_result[1] > 0);
                  print("is_part_num = {}\n", .{is_part_num});
                } else {
                }

            },
            '8' => {
                is_num = true;
                number = (number * 10) + 8;
                if (is_part_num != true) {
                  print("sym result = {}\n", .{sym_result});
                  sym_result = try sym_check(per_line_counter, line_num); 
                  is_part_num = (sym_result[0] > 0) and (sym_result[1] > 0);
                  print("is_part_num = {}\n", .{is_part_num});
                } else {
                }

            },
            '9' => {
                is_num = true;
                number = (number * 10) + 9;
                if (is_part_num != true) {
                  print("sym result = {}\n", .{sym_result});
                  sym_result = try sym_check(per_line_counter, line_num); 
                  is_part_num = (sym_result[0] > 0) and (sym_result[1] > 0);
                  print("is_part_num = {}\n", .{is_part_num});
                } else {
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
              var gear_found: bool = false;
              
              print("part arr items = {d}\n", .{part_struct_arr.items.len});

              // need to figure out where to populate part_struct_arr.items in order for the following code to work correctly
              for (part_struct_arr.items[0..]) |part| {
                  print("part vector = {d} {d}\n", .{part.part_vector[0], part.part_vector[1]});

                  if (sym_result[0] == part.part_vector[0] and sym_result[1] == part.part_vector[1]) {
                      result += part.part_num * number;
                      gear_found = true;
                      print("\n", .{});
                      print("result = {} sym result = {}\n", .{result, sym_result});
                      print("\n", .{});
                  }
              }
              
              if (gear_found == false) {
                print("sym arr items = {d}\n", .{sym_arr.items.len});
                try part_struct_arr.append(try part_struct.create(sym_result[0], sym_result[1], number));
                print("new number = {}\n", .{number});
              }

            }

            number = 0;
            is_num = false;
            is_part_num = false;

          }
        }
    }
}
