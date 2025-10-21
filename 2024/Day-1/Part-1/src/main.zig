const std = @import("std");
const print = @import("std").debug.print;
const embedfile = @embedFile("s");

var first_list: bool = undefined;
var second_list: bool = undefined;
var running_total: u32 = 0;

pub fn main() !void {
    var buffer: [1000]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    var map = std.StringHashMap([]const u8).init(allocator);
    defer map.deinit();
    
    const keys = [_][]const u8 {
        "0",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7", 
        "8",
        "9",
        "",
        "\n",
    };
    const values = [_][]const u8 {
        "zero", 
        "one",
        "two",
        "three",
        "four",
        "five",
        "six",
        "seven",
        "eight",
        "nine",
        "space",
        "newline",
    };

    for (keys, values) |key, value| {
        try map.put(key, value);
        print("key:value {s}:{s}\n", .{key, value});
    }

    var lines = std.mem.splitAny(u8, embedfile, "\n");
    while (lines.next()) |line| {
        var sequence = std.mem.splitAny(u8, line, " ");
        while (sequence.next()) |seq1| {
            if (map.get(seq1)) |word| {
                print("word = {s}\n", .{word});
                print("seq1 = {s}\n", .{seq1});
                if (std.mem.eql(u8, word, "space")) {
                    //print("running_total = {d}\n", .{running_total});
                    if (first_list == true) {
                        first_list = false;
                    } 
                    running_total = 0;
                } else if (std.mem.eql(u8, word, "newline")) {
                    //print("running_total = {d}\n", .{running_total});
                    if (second_list == true) {
                        second_list = false;
                    } 
                    running_total = 0;
                } else if (std.mem.eql(u8, seq1, "\n")) {
                    //print("running_total = {d}\n", .{running_total});
                    if (second_list == true) {
                        second_list = false;
                    } 
                    running_total = 0;
                } else {
                    running_total *= 10;
                    const key_int: u32 = try std.fmt.parseInt(u32, seq1, 10);
                    running_total += key_int;
                    print("running_total = {d}\n", .{running_total});

                    //if (first_list == true) {
                    //    var keyIt = map.keyIterator();
                    //    //i think there is a problem with the key keyIterator as it doesnt look like it is getting the right keys
                    //    while (keyIt.next()) |key| {
                    //        var key_int: u32 = try std.fmt.parseInt(u32, key.*, 10);
                    //    }

                    //} else {
                    //    second_list = true;
                    //    //add the number to the index notation
                    //    digit_count = 0;
                    //}
                    
                } 
            } else {
                print("could not find key, seq1 = {s}\n", .{seq1});
            }
        }
        print("newline\n", .{});
        second_list = false;
        first_list = true;

        running_total = 0;
    }
}
