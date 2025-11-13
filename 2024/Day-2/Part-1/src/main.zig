const std = @import("std");
const print = @import("std").debug.print;

var running_total: u32 = 0;
var report: u32 = 1;
var safe_report: bool = false;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var arr_list: std.ArrayList(u32) = .empty;
    var safe_reports: std.ArrayList(u32) = .empty;
    defer arr_list.deinit(allocator);

    var file_buffer: [50]u8 = undefined; //change to 15,000 on final run
    const file_reader = try std.fs.File.read(try std.fs.cwd().openFile("s", .{}), &file_buffer);
    _ = file_reader;
    for (file_buffer) |char| {
        print("char = {c}\n", .{char});
        if (char == ' ') {
            if (running_total > 0) {
                try arr_list.append(allocator, running_total);
                print("arry_list = {any}\n", .{arr_list.items});
            }
            running_total = 0;
        } else if (char == '\n') {
            if (running_total > 0) {
                try arr_list.append(allocator, running_total);
                print("arry_list = {any}\n", .{arr_list.items});
            }
            running_total = 0;
            report += 1;
            
            if (safe_report) {
                try safe_reports.append(allocator, report);
            }
        } else if (char >= '0' and char <= '9') {
            running_total *= 10;
            running_total += char - 48;
            //need to work out how to find the previous number
            //check if increased or decreased from the previous number
            //check if difference is between 1 and 3
            //if both conditions return true then mark as a safe report
            print("running total = {}\n", .{running_total});

        }
    }
    
    running_total = 0;
}
