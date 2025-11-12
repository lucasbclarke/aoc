const std = @import("std");
const print = @import("std").debug.print;

var first_list: bool = true;
var second_list: bool = undefined;
var running_total: u32 = 0;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var arr_list: std.ArrayList(u32) = .empty;
    var first_arr_list: std.ArrayList(u32) = .empty;
    var second_arr_list: std.ArrayList(u32) = .empty;
    defer arr_list.deinit(allocator);

    var file_buffer: [15000]u8 = undefined; //change to 15,000 on final run
    const file_reader = try std.fs.File.read(try std.fs.cwd().openFile("s", .{}), &file_buffer);
    _ = file_reader;
    for (file_buffer) |char| {
        print("char = {c}\n", .{char});
        if (char == ' ') {
            if (first_list == true) {
                first_list = false;
                second_list = true;
            }
            if (running_total > 0) {
                try arr_list.append(allocator, running_total);
                print("arry_list = {any}\n", .{arr_list.items});
            }
            running_total = 0;
        } else if (char == '\n') {
            if (second_list == true) {
                second_list = false;
            }
            if (running_total > 0) {
                try arr_list.append(allocator, running_total);
                print("arry_list = {any}\n", .{arr_list.items});
            }
            running_total = 0;
        } else if (char >= '0' and char <= '9') {
            if (first_list == false and second_list == false) {
                first_list = true;
            }
            running_total *= 10;
            running_total += char - 48;
            print("first list = {}\n", .{first_list});
            print("second list = {}\n", .{second_list});
        }
    }
    
    print("loop ended, arry_list = {any}\n", .{arr_list.items});
    print("\n", .{});
    for (arr_list.items, 1..) |item, i| {
        print("item = {}\n", .{item});
        if ( i % 2 == 0) {
            try second_arr_list.append(allocator, item);
            std.mem.sort(u32, second_arr_list.items, {}, std.sort.asc(u32));
            print("second_arry_list = {any}\n", .{second_arr_list.items});
        } else {
            try first_arr_list.append(allocator, item);
            std.mem.sort(u32, first_arr_list.items, {}, std.sort.asc(u32));
            print("first_arry_list = {any}\n", .{first_arr_list.items});
        }
    }
    
    var similarity_total: u32 = 0;
    for (first_arr_list.items) |item1| {
        var count: u32 = 0;
        for (second_arr_list.items) |item2| {
            if (item1 == item2) {
                count += 1;
            }
        }
        const similarity = item1 * count;
        print("{} * {} = {}\n", .{item1, count ,similarity});
        similarity_total += similarity;
    }
    print("total similarity = {}\n", .{similarity_total});

    running_total = 0;
}
