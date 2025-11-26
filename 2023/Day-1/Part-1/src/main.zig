const std = @import("std");
const print = @import("std").debug.print;

var int_buf: [2]u8 = undefined;
var fbs = std.io.fixedBufferStream(&int_buf);

var found_first_number: bool = false;
var found_last_number: bool = false;

var first_number: u8 = 0;
var last_number: u8 = 0;

var total: u64 = 0;

pub fn main() !void{

    var file = try std.fs.cwd().openFile("s", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [1024]u8 = undefined;
    var i: usize = 0;

    while (true) {
        const result_n = try in_stream.readUntilDelimiterOrEof(buf[0..], '\n');
        if (result_n == null) break;
        i = 0;

        while (buf[i] != '\n' ){

            if (buf[i] >= '0' and buf[i] <= '9') {

                if (found_first_number == false) {
                    found_first_number = true;
                    first_number = buf[i] - 48;
                }

                found_last_number = true;
                last_number = buf[i] - 48;
            }

            i+=1;

        }

        var total_line: u8 = 0;
        total_line = (first_number * 10) + last_number;
        print("{s}\n", .{"The total of this line ="});
        print("{d}\n", .{total_line});
        
        total += total_line;

        found_first_number = false;
        found_last_number = false;
    }
    print("{s}\n", .{"The total of every line ="});
    print("{d}\n", .{total});
}
