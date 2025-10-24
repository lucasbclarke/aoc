const std = @import("std");
const print = @import("std").debug.print;
const embedfile = @embedFile("s");

var first_list: bool = undefined;
var second_list: bool = undefined;
var running_total: u32 = 1;

pub fn main() !void {
    var lines = std.mem.splitAny(u8, embedfile, "\n");
    while (lines.next()) |line| {
        for (line) |seq1| {
            print("seq1 = {c}\n", .{seq1});
            if (seq1 == ' ') {
                //print("running_total = {d}\n", .{running_total});
                if (first_list == true) {
                    first_list = false;
                } 
                running_total = 0;
            } else if (seq1 == '\n') {
                //print("running_total = {d}\n", .{running_total});
                if (second_list == true) {
                    second_list = false;
                } 
                running_total = 0;
            } else if (seq1 >= '0' and seq1 <= '9') {
                print("seq1 within if statement = {c}\n", .{seq1});
                print("running_total before multiplication = {d}\n", .{running_total});
                running_total *= 10;
                print("running_total before adition = {d}\n", .{running_total});
                running_total += seq1 - 48;
                print("running_total after adition = {d}\n", .{running_total});
            }
        }
        print("newline\n", .{});
        second_list = false;
        first_list = true;

        running_total = 0;
    }
}
