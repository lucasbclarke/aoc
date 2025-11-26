const std = @import("std");
const print = @import("std").debug.print;

var running_total: u32 = 0;
var report: u32 = 0;
var safe_report: bool = true;
var number_index: u32 = 0;
var prev_number: u32 = undefined;
var new_line_started: bool = true;
var direction: i8 =  0;
var line_direction: i8 =  0;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var arr_list: std.ArrayList(u32) = .empty;
    var safe_reports: std.ArrayList(u32) = .empty;
    defer arr_list.deinit(allocator);

    var file_buffer: [20000]u8 = undefined; //change to 15,000 on final run
    const file_reader = try std.fs.File.read(try std.fs.cwd().openFile("s", .{}), &file_buffer);
    _ = file_reader;
    for (file_buffer) |char| {
        print("char = {c}\n", .{char});
        if (char == ' ') {
            
            if (running_total > 0) {
                try arr_list.append(allocator, running_total);
                //print("arry_list = {any}\n", .{arr_list.items});
            }
            if (!new_line_started) { 
                if (number_index > 0) {
                    safe_report &= numberComparison(running_total, prev_number, &line_direction);
                } else {
                    print("previous number = running_total\n", .{});
                    safe_report &= false;
                }
            }
            print("report safe = {}\n", .{safe_report});
            new_line_started = false;
            prev_number = running_total;
            running_total = 0;
        } else if (char == '\n') {
            if (!new_line_started) { 
                if (number_index > 0) {
                    safe_report &= numberComparison(running_total, prev_number, &line_direction);
                } else {
                    print("previous number = running_total\n", .{});
                    safe_report &= false;
                }
            }
            print("report safe = {}\n", .{safe_report});

            if (running_total > 0) {
                try arr_list.append(allocator, running_total);
                //print("arry_list = {any}\n", .{arr_list.items});
            }
            prev_number = running_total;
            running_total = 0;
            report += 1;
            print("report = {}\n", .{report});
            
            if (safe_report) {
                try safe_reports.append(allocator, report);
            }
            prev_number = 0;
            safe_report = true;
            new_line_started = true;
            print("new_line_started\n", .{});
            line_direction = 0;
        } else if (char >= '0' and char <= '9') {
            running_total *= 10;
            running_total += char - 48;
            
            number_index += 1;
        }
    }

    print("safe reports = {any}\n", .{safe_reports.items});
    print("amount of safe reports = {d}\n", .{safe_reports.items.len});
    
    running_total = 0;
}

pub fn numberComparison(runningTotal: u32, prevNumber: u32, lineDirection: *i8) bool {
    if (prevNumber != runningTotal) {
        print("prev number = {}\n", .{prevNumber});
        print("running_total = {}\n", .{runningTotal});

        if (prevNumber > runningTotal) {
            if (prevNumber - runningTotal == 1 or
                prevNumber - runningTotal == 2 or
                prevNumber - runningTotal == 3) {
                print("subtraction between 1 and 3\n", .{});
                direction = -1;
                if (lineDirection.* == 0 or lineDirection.* == direction) {
                    safe_report &= true;
                    lineDirection.* = direction;
                } else {
                    safe_report &= false;
                }
            } else {
                print("subtraction not between 1 and 3\n", .{});
                safe_report &= false;
            }
        } else if (prevNumber < runningTotal) {
            if (runningTotal - prevNumber == 1 or
                runningTotal - prevNumber == 2 or
                runningTotal - prevNumber == 3) {
                print("addition between 1 and 3 \n", .{});
                safe_report &= true;
                direction = 1;
                if (lineDirection.* == 0 or lineDirection.* == direction) {
                    safe_report &= true;
                    lineDirection.* = direction;
                } else {
                    safe_report &= false;
                }
            } else {
                print("addition not between 1 and 3\n", .{});
                safe_report &= false;
            }
        } 
    } else {
        safe_report &= false;
    }
    return safe_report;
}
