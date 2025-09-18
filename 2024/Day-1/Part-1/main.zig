const std = @import("std");
const print = @import("std").debug.print;
const embedfile = @embedFile("s");

var first_list: bool = undefined;
var second_list: bool = undefined;
var digit_count: u32 = 0;

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
                print("{s}\n", .{word});
                if (std.mem.eql(u8, word, "space")) {
                    if (first_list == true) {
                        first_list = false;
                    } else {
                        print("this should not happen", .{});
                    }
                    digit_count = 0;
                }
                if (std.mem.eql(u8, word, "newline")) {
                    if (second_list == true) {
                        second_list = false;
                    } else {
                        print("this should not happen", .{});
                    }
                    digit_count = 0;
                }
                if (std.mem.eql(u8, word, "one")) {
                    digit_count += 1;
                    if (first_list == true) {
                        //add the number to the index notation
                        var keyIt = map.keyIterator();
                        while (keyIt.next()) |key| {
                            print("key?", .{});
                                switch (digit_count) {
                                    '1' => { key *= 10000; },
                                    '2' => { key *= 1000; },
                                    '3' => { key *= 100; },
                                    '4' => { key *= 10; },
                                    '5' => { key *= 1; },
                                    else => {
                                        print("this should not happen", .{});
                                    }
                                }
                        }

                    } else {
                        second_list == true;
                        //add the number to the index notation
                    }
                }
                if (std.mem.eql(u8, word, "two")) {
                    
                }
                if (std.mem.eql(u8, word, "three")) {
                }
                if (std.mem.eql(u8, word, "four")) {
                }
                if (std.mem.eql(u8, word, "five")) {
                }
                if (std.mem.eql(u8, word, "six")) {
                }
                if (std.mem.eql(u8, word, "seven")) {
                }
                if (std.mem.eql(u8, word, "eight")) {
                }
                if (std.mem.eql(u8, word, "nine")) {
                }
            }
        }
        print("newline\n", .{});
    }

}
