const std = @import("std");
const print = @import("std").debug.print;

var first_list: bool = true;
var second_list: bool = undefined;
var running_total: u32 = 1;

const arr_list = std.ArrayList(u32);

pub fn main() !void {
    var file_buffer: [40]u8 = undefined;
    const file_reader = try std.fs.File.read(try std.fs.cwd().openFile("s", .{}), &file_buffer);
    _ = file_reader;
    for (file_buffer) |char| {
        print("char = {c}\n", .{char});
        if (char == ' ') {
            if (first_list == true) {
                first_list = false;
                second_list = true;
            }
            running_total = 0;
        } else if (char == '\n') {
            if (second_list == true) {
                second_list = false;
            } 
            running_total = 0;
        } else if (char >= '0' and char <= '9') {
            if (first_list == false and second_list == false) {
                first_list = true;
            }
            print("running_total before multiplication = {d}\n", .{running_total});
            running_total *= 10;
            print("running_total before adition = {d}\n", .{running_total});
            running_total += char - 48;
            print("running_total after adition = {d}\n", .{running_total});
            arr_list.append(std.heap.GeneralPurposeAllocator(.{}), running_total);
            print("arry_list = {}", .{arr_list});
        }
    }
    running_total = 0;
    //var lines = std.mem.splitAny(u8, embedfile, "\n");
    //while (lines.next()) |line| {
    //    for (line) |seq1| {
    //        print("seq1 = {c}\n", .{seq1});
    //        if (seq1 == ' ') {
    //            //print("running_total = {d}\n", .{running_total});
    //            print("seq1 = space\n", .{});
    //            if (first_list == true) {
    //                first_list = false;
    //            } 
    //            running_total = 0;
    //        } else if (seq1 == '\n') {
    //            //print("running_total = {d}\n", .{running_total});
    //            print("seq1 = newline\n", .{});
    //            if (second_list == true) {
    //                second_list = false;
    //            } 
    //            running_total = 0;
    //        } else if (seq1 >= '0' and seq1 <= '9') {
    //            print("seq1 within if statement = {c}\n", .{seq1});
    //            print("running_total before multiplication = {d}\n", .{running_total});
    //            running_total *= 10;
    //            print("running_total before adition = {d}\n", .{running_total});
    //            running_total += seq1 - 48;
    //            print("running_total after adition = {d}\n", .{running_total});
    //        }
    //    }
    //    print("newline\n", .{});
    //    second_list = false;
    //    first_list = true;

    //    running_total = 0;
    //}
    
}
