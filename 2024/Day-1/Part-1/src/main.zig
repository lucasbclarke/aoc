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
                    } 
                    digit_count = 0;
                } else if (std.mem.eql(u8, word, "newline")) {
                    if (second_list == true) {
                        second_list = false;
                    } 
                    digit_count = 0;
                } else if (std.mem.eql(u8, word, "one")) {
                    digit_count += 1;
                    if (first_list == true) {
                        var keyIt = map.keyIterator();
                        //i think there is a problem with the key keyIterator as it doesnt look like it is getting the right keys
                        while (keyIt.next()) |key| {
                            var key_int: u32 = try std.fmt.parseInt(u32, key.*, 10);
                            switch (digit_count) {
                                1 => { key_int *= 10000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                2 => { key_int *= 1000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                3 => { key_int *= 100; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                4 => { key_int *= 10; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                5 => { key_int *= 1; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                else => {
                                    print("digit_count = {d}\n", .{digit_count});
                                }
                            }
                        }

                    } else {
                        second_list = true;
                        //add the number to the index notation
                    }
                } else if (std.mem.eql(u8, word, "two")) {
                    digit_count += 1;
                    if (first_list == true) {
                        var keyIt = map.keyIterator();
                        while (keyIt.next()) |key| {
                            var key_int: u32 = try std.fmt.parseInt(u32, key.*, 10);
                            switch (digit_count) {
                                1 => { key_int *= 10000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                2 => { key_int *= 1000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                3 => { key_int *= 100; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                4 => { key_int *= 10; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                5 => { key_int *= 1; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                else => {
                                    print("digit_count = {d}\n", .{digit_count});
                                }
                            }
                        }

                    } else {
                        second_list = true;
                        //add the number to the index notation
                    }
                } else if (std.mem.eql(u8, word, "three")) {
                    digit_count += 1;
                    if (first_list == true) {
                        var keyIt = map.keyIterator();
                        while (keyIt.next()) |key| {
                            var key_int: u32 = try std.fmt.parseInt(u32, key.*, 10);
                            switch (digit_count) {
                                1 => { key_int *= 10000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                2 => { key_int *= 1000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                3 => { key_int *= 100; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                4 => { key_int *= 10; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                5 => { key_int *= 1; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                else => {
                                    print("digit_count = {d}\n", .{digit_count});
                                }
                            }
                        }

                    } else {
                        second_list = true;
                        //add the number to the index notation
                    }
                } else if (std.mem.eql(u8, word, "four")) {
                    digit_count += 1;
                    if (first_list == true) {
                        var keyIt = map.keyIterator();
                        while (keyIt.next()) |key| {
                            var key_int: u32 = try std.fmt.parseInt(u32, key.*, 10);
                            switch (digit_count) {
                                1 => { key_int *= 10000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                2 => { key_int *= 1000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                3 => { key_int *= 100; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                4 => { key_int *= 10; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                5 => { key_int *= 1; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                else => {
                                    print("digit_count = {d}\n", .{digit_count});
                                }
                            }
                        }

                    } else {
                        second_list = true;
                        //add the number to the index notation
                    }
                } else if (std.mem.eql(u8, word, "five")) {

                    digit_count += 1;
                    if (first_list == true) {
                        var keyIt = map.keyIterator();
                        while (keyIt.next()) |key| {
                            var key_int: u32 = try std.fmt.parseInt(u32, key.*, 10);
                            switch (digit_count) {
                                1 => { key_int *= 10000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                2 => { key_int *= 1000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                3 => { key_int *= 100; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                4 => { key_int *= 10; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                5 => { key_int *= 1; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                else => {
                                    print("digit_count = {d}\n", .{digit_count});
                                }
                            }
                        }

                    } else {
                        second_list = true;
                        //add the number to the index notation
                    }
                } else if (std.mem.eql(u8, word, "six")) {
                    digit_count += 1;
                    if (first_list == true) {
                        var keyIt = map.keyIterator();
                        while (keyIt.next()) |key| {
                            var key_int: u32 = try std.fmt.parseInt(u32, key.*, 10);
                            switch (digit_count) {
                                1 => { key_int *= 10000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                2 => { key_int *= 1000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                3 => { key_int *= 100; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                4 => { key_int *= 10; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                5 => { key_int *= 1; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                else => {
                                    print("digit_count = {d}\n", .{digit_count});
                                }
                            }
                        }

                    } else {
                        second_list = true;
                        //add the number to the index notation
                    }
                } else if (std.mem.eql(u8, word, "seven")) {
                    digit_count += 1;
                    if (first_list == true) {
                        var keyIt = map.keyIterator();
                        while (keyIt.next()) |key| {
                            var key_int: u32 = try std.fmt.parseInt(u32, key.*, 10);
                            switch (digit_count) {
                                1 => { key_int *= 10000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                2 => { key_int *= 1000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                3 => { key_int *= 100; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                4 => { key_int *= 10; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                5 => { key_int *= 1; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                else => {
                                    print("digit_count = {d}\n", .{digit_count});
                                }
                            }
                        }

                    } else {
                        second_list = true;
                        //add the number to the index notation
                    }
                } else if (std.mem.eql(u8, word, "eight")) {
                    digit_count += 1;
                    if (first_list == true) {
                        var keyIt = map.keyIterator();
                        while (keyIt.next()) |key| {
                            var key_int: u32 = try std.fmt.parseInt(u32, key.*, 10);
                            switch (digit_count) {
                                1 => { key_int *= 10000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                2 => { key_int *= 1000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                3 => { key_int *= 100; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                4 => { key_int *= 10; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                5 => { key_int *= 1; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                else => {
                                    print("digit_count = {d}\n", .{digit_count});
                                }
                            }
                        }

                    } else {
                        second_list = true;
                        //add the number to the index notation
                    }
                } else if (std.mem.eql(u8, word, "nine")) {
                    digit_count += 1;
                    if (first_list == true) {
                        var keyIt = map.keyIterator();
                        while (keyIt.next()) |key| {
                            var key_int: u32 = try std.fmt.parseInt(u32, key.*, 10);
                            switch (digit_count) {
                                1 => { key_int *= 10000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                2 => { key_int *= 1000; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                3 => { key_int *= 100; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                4 => { key_int *= 10; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                5 => { key_int *= 1; print("key_int = {d}\n", .{key_int}); print("digit_count = {d}\n", .{digit_count}); },
                                else => {
                                    print("digit_count = {d}\n", .{digit_count});
                                }
                            }
                        }

                    } else {
                        second_list = true;
                        //add the number to the index notation
                    }
                } else {
                    print("word is not found in map, word = {s}", .{word});
                }
            } else {
                 print("could not find key, seq1 = {s}", .{seq1});
            }
        }
        print("newline\n", .{});
        second_list = false;
        first_list = true;
    }

}
