const std = @import("std");
const print = @import("std").debug.print;

var first_list: bool = true;
var second_list: bool = undefined;
var running_total: u32 = 0;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var arr_list: std.ArrayList(u32) = .empty;
    defer arr_list.deinit(allocator);

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
            try arr_list.append(allocator, running_total);
            print("arry_list = {any}\n", .{arr_list.items});

            var i: u32 = 0;
            for (arr_list.items) |item| {
                print("item = {}\n", .{item});
                i += 1;
                print("i = {}\n", .{i});
                if (i % 3 == 0) {
                    if (item / 10 < 10) {
                        _ = arr_list.orderedRemove(i);
                    }
                }
            }
        }
    }
    running_total = 0;
}
