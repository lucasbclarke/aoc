const std = @import("std");
const print = @import("std").debug.print;

const Int = usize;

var int_buf: [2]u8 = undefined;
var fbs = std.io.fixedBufferStream(&int_buf);

var found_first_number: bool = false;
var found_last_number: bool = false;

var first_number: u8 = undefined;
var last_number: u8 = undefined;

var first_number_arr: []u8 = undefined;
var last_number_arr: []u8 = undefined;

var total: u64 = 0;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer std.debug.assert(gpa.deinit() == .ok);

    var first_number_list = std.ArrayList(u8).init(allocator);
    defer first_number_list.deinit();

    var last_number_list = std.ArrayList(u8).init(allocator);
    defer last_number_list.deinit();

    var debug_first_number_list = std.ArrayList(u8).init(allocator);
    defer debug_first_number_list.deinit();

    var debug_last_number_list = std.ArrayList(u8).init(allocator);
    defer debug_last_number_list.deinit();

    var file = try std.fs.cwd().openFile("s", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [999999]u8 = undefined;
    var i: usize = 0;
    var debug_buf: [999999]u8 = undefined;
    var edge_case_counter: u8 = 0;

    while (true) {
        const result_n = try in_stream.readUntilDelimiterOrEof(buf[0..], '\n');
        if (result_n == null) break;
        i = 0;

        debug_buf = buf;
        while (buf[i] != '\n') {
            if (buf[i] >= '0' and buf[i] <= '9') {
                if (found_first_number == false) {
                    found_first_number = true;
                    first_number = buf[i] - 48;
                    print("{s}\n", .{"found a numeric value"});
                    print("{d}\n", .{first_number});
                    try debug_first_number_list.append(first_number);
                    try first_number_list.append(buf[i]);
                    first_number_list.clearAndFree();
                    i += 1;
                } else {
                    found_last_number = true;
                    last_number = buf[i] - 48;
                    print("{s}\n", .{"found a numeric value"});
                    print("{d}\n", .{last_number});
                    try debug_last_number_list.append(first_number);
                    try last_number_list.append(buf[i]);
                    last_number_list.clearAndFree();
                    i += 1;
                }
            } else if (buf[i] == 'o') {
                first_number_list.clearAndFree();
                if (found_first_number == false) {
                    try first_number_list.append(buf[i]);
                    try debug_first_number_list.append(buf[i]);
                    i += 1;

                    if (buf[i] == 'n') {
                        try first_number_list.append(buf[i]);
                        try debug_first_number_list.append(buf[i]);

                        if (buf[i + 1] == 'e') {
                            first_number = 1;
                            found_first_number = true;
                            try first_number_list.append(buf[i + 1]);
                            try debug_first_number_list.append(buf[i + 1]);
                            print("{s}\n", .{"found a word"});
                            print("{s}\n", .{first_number_list.items});
                            print("{d}\n", .{first_number});
                            first_number_list.clearAndFree();
                        }
                    } else {
                        first_number_list.clearAndFree();
                    }
                } else {
                    last_number_list.clearAndFree();
                    try last_number_list.append(buf[i]);
                    try debug_last_number_list.append(buf[i]);
                    i += 1;

                    if (buf[i] == 'n') {
                        try last_number_list.append(buf[i]);
                        try debug_last_number_list.append(buf[i]);

                        if (buf[i + 1] == 'e') {
                            last_number = 1;
                            found_last_number = true;
                            try last_number_list.append(buf[i + 1]);
                            try debug_last_number_list.append(buf[i + 1]);
                            print("{s}\n", .{"found a word"});
                            print("{s}\n", .{last_number_list.items});
                            print("{d}\n", .{last_number});
                            last_number_list.clearAndFree();
                        }
                    } else {
                        last_number_list.clearAndFree();
                    }
                }
            } else if (buf[i] == 't') {
                first_number_list.clearAndFree();
                if (found_first_number == false) {
                    try first_number_list.append(buf[i]);
                    try debug_first_number_list.append(buf[i]);
                    i += 1;

                    if (buf[i] == 'w') {
                        try first_number_list.append(buf[i]);
                        try debug_first_number_list.append(buf[i]);

                        if (buf[i + 1] == 'o') {
                            first_number = 2;
                            found_first_number = true;
                            try first_number_list.append(buf[i + 1]);
                            try debug_first_number_list.append(buf[i + 1]);
                            print("{s}\n", .{"found a word"});
                            print("{s}\n", .{first_number_list.items});
                            print("{d}\n", .{first_number});
                            first_number_list.clearAndFree();
                        }
                    } else if (buf[i] == 'h') {
                        try first_number_list.append(buf[i]);
                        try debug_first_number_list.append(buf[i]);

                        if (buf[i + 1] == 'r') {
                            try first_number_list.append(buf[i + 1]);
                            try debug_first_number_list.append(buf[i + 1]);

                            if (buf[i + 2] == 'e') {
                                try first_number_list.append(buf[i + 2]);
                                try debug_first_number_list.append(buf[i + 2]);

                                if (buf[i + 3] == 'e') {
                                    first_number = 3;
                                    found_first_number = true;
                                    try first_number_list.append(buf[i + 3]);
                                    try debug_first_number_list.append(buf[i + 3]);
                                    print("{s}\n", .{"found a word"});
                                    print("{s}\n", .{first_number_list.items});
                                    print("{d}\n", .{first_number});
                                    first_number_list.clearAndFree();
                                }
                            }
                        }
                    } else {
                        first_number_list.clearAndFree();
                    }
                } else {
                    last_number_list.clearAndFree();
                    try last_number_list.append(buf[i]);
                    try debug_last_number_list.append(buf[i]);
                    i += 1;

                    if (buf[i] == 'w') {
                        try last_number_list.append(buf[i]);
                        try debug_last_number_list.append(buf[i]);

                        if (buf[i + 1] == 'o') {
                            last_number = 2;
                            found_last_number = true;
                            try last_number_list.append(buf[i + 1]);
                            try debug_last_number_list.append(buf[i + 1]);
                            print("{s}\n", .{"found a word"});
                            print("{s}\n", .{last_number_list.items});
                            print("{d}\n", .{last_number});
                            last_number_list.clearAndFree();
                        }
                    } else if (buf[i] == 'h') {
                        try last_number_list.append(buf[i]);
                        try debug_last_number_list.append(buf[i]);

                        if (buf[i + 1] == 'r') {
                            try last_number_list.append(buf[i + 1]);
                            try debug_last_number_list.append(buf[i + 1]);

                            if (buf[i + 2] == 'e') {
                                try last_number_list.append(buf[i + 2]);
                                try debug_last_number_list.append(buf[i + 2]);

                                if (buf[i + 3] == 'e') {
                                    last_number = 3;
                                    found_last_number = true;
                                    try last_number_list.append(buf[i + 3]);
                                    try debug_last_number_list.append(buf[i + 3]);
                                    print("{s}\n", .{"found a word"});
                                    print("{s}\n", .{last_number_list.items});
                                    print("{d}\n", .{last_number});
                                    last_number_list.clearAndFree();
                                }
                            }
                        }
                    } else {
                        last_number_list.clearAndFree();
                    }
                }
            } else if (buf[i] == 'f') {
                first_number_list.clearAndFree();
                if (found_first_number == false) {
                    try first_number_list.append(buf[i]);
                    try debug_first_number_list.append(buf[i]);
                    i += 1;

                    if (buf[i] == 'o') {
                        try first_number_list.append(buf[i]);
                        try debug_first_number_list.append(buf[i]);

                        if (buf[i + 1] == 'u') {
                            try first_number_list.append(buf[i + 1]);
                            try debug_first_number_list.append(buf[i + 1]);

                            if (buf[i + 2] == 'r') {
                                first_number = 4;
                                found_first_number = true;
                                try first_number_list.append(buf[i + 2]);
                                try debug_first_number_list.append(buf[i + 2]);
                                print("{s}\n", .{"found a word"});
                                print("{s}\n", .{first_number_list.items});
                                print("{d}\n", .{first_number});
                                first_number_list.clearAndFree();
                            }
                        }
                    } else if (buf[i] == 'i') {
                        try first_number_list.append(buf[i]);
                        try debug_first_number_list.append(buf[i]);
                        i += 1;

                        if (buf[i] == 'v') {
                            try first_number_list.append(buf[i]);
                            try debug_first_number_list.append(buf[i]);

                            if (buf[i + 1] == 'e') {
                                first_number = 5;
                                found_first_number = true;
                                try first_number_list.append(buf[i + 1]);
                                try debug_first_number_list.append(buf[i + 1]);
                                print("{s}\n", .{"found a word"});
                                print("{s}\n", .{first_number_list.items});
                                print("{d}\n", .{first_number});
                                first_number_list.clearAndFree();
                            }
                        }
                    } else {
                        first_number_list.clearAndFree();
                    }
                } else {
                    last_number_list.clearAndFree();
                    try last_number_list.append(buf[i]);
                    try debug_last_number_list.append(buf[i]);
                    i += 1;

                    if (buf[i] == 'o') {
                        try last_number_list.append(buf[i]);
                        try debug_last_number_list.append(buf[i]);

                        if (buf[i + 1] == 'u') {
                            try last_number_list.append(buf[i + 1]);
                            try debug_last_number_list.append(buf[i + 1]);

                            if (buf[i + 2] == 'r') {
                                last_number = 4;
                                found_last_number = true;
                                try last_number_list.append(buf[i + 2]);
                                try debug_last_number_list.append(buf[i + 2]);
                                print("{s}\n", .{"found a word"});
                                print("{s}\n", .{last_number_list.items});
                                print("{d}\n", .{last_number});
                                last_number_list.clearAndFree();
                            }
                        }
                    } else if (buf[i] == 'i') {
                        try last_number_list.append(buf[i]);
                        try debug_last_number_list.append(buf[i]);

                        if (buf[i + 1] == 'v') {
                            try last_number_list.append(buf[i + 1]);
                            try debug_last_number_list.append(buf[i + 1]);

                            if (buf[i + 2] == 'e') {
                                last_number = 5;
                                found_last_number = true;
                                try last_number_list.append(buf[i + 2]);
                                try debug_last_number_list.append(buf[i + 2]);
                                print("{s}\n", .{"found a word"});
                                print("{s}\n", .{last_number_list.items});
                                print("{d}\n", .{last_number});
                                last_number_list.clearAndFree();
                            }
                        }
                    } else {
                        last_number_list.clearAndFree();
                    }
                }
            } else if (buf[i] == 's') {
                first_number_list.clearAndFree();
                if (found_first_number == false) {
                    try first_number_list.append(buf[i]);
                    try debug_first_number_list.append(buf[i]);
                    i += 1;

                    if (buf[i] == 'i') {
                        try first_number_list.append(buf[i]);
                        try debug_first_number_list.append(buf[i]);

                        if (buf[i + 1] == 'x') {
                            first_number = 6;
                            found_first_number = true;
                            try first_number_list.append(buf[i + 1]);
                            try debug_first_number_list.append(buf[i + 1]);
                            print("{s}\n", .{"found a word"});
                            print("{s}\n", .{first_number_list.items});
                            print("{d}\n", .{first_number});
                            first_number_list.clearAndFree();
                            i += 1;
                        }
                    } else if (buf[i] == 'e') {
                        try first_number_list.append(buf[i]);
                        try debug_first_number_list.append(buf[i]);

                        if (buf[i + 1] == 'v') {
                            try first_number_list.append(buf[i + 1]);
                            try debug_first_number_list.append(buf[i + 1]);

                            if (buf[i + 2] == 'e') {
                                try first_number_list.append(buf[i + 2]);
                                try debug_first_number_list.append(buf[i + 2]);

                                if (buf[i + 3] == 'n') {
                                    first_number = 7;
                                    found_first_number = true;
                                    try first_number_list.append(buf[i + 3]);
                                    try debug_first_number_list.append(buf[i + 3]);
                                    print("{s}\n", .{"found a word"});
                                    print("{s}\n", .{first_number_list.items});
                                    print("{d}\n", .{first_number});
                                    first_number_list.clearAndFree();
                                }
                            }
                        }
                    } else {
                        first_number_list.clearAndFree();
                    }
                } else {
                    last_number_list.clearAndFree();
                    try last_number_list.append(buf[i]);
                    try debug_last_number_list.append(buf[i]);
                    i += 1;

                    if (buf[i] == 'i') {
                        try last_number_list.append(buf[i]);
                        try debug_last_number_list.append(buf[i]);

                        if (buf[i + 1] == 'x') {
                            last_number = 6;
                            found_last_number = true;
                            try last_number_list.append(buf[i + 1]);
                            try debug_last_number_list.append(buf[i + 1]);
                            print("{s}\n", .{"found a word"});
                            print("{s}\n", .{last_number_list.items});
                            print("{d}\n", .{last_number});
                            last_number_list.clearAndFree();
                        }
                    } else if (buf[i] == 'e') {
                        try last_number_list.append(buf[i]);
                        try debug_last_number_list.append(buf[i]);

                        if (buf[i + 1] == 'v') {
                            try last_number_list.append(buf[i + 1]);
                            try debug_last_number_list.append(buf[i + 1]);

                            if (buf[i + 2] == 'e') {
                                try last_number_list.append(buf[i + 2]);
                                try debug_last_number_list.append(buf[i + 2]);

                                if (buf[i + 3] == 'n') {
                                    last_number = 7;
                                    found_last_number = true;
                                    try last_number_list.append(buf[i + 3]);
                                    try debug_last_number_list.append(buf[i + 3]);
                                    print("{s}\n", .{"found a word"});
                                    print("{s}\n", .{last_number_list.items});
                                    print("{d}\n", .{last_number});
                                    last_number_list.clearAndFree();
                                }
                            }
                        }
                    } else {
                        last_number_list.clearAndFree();
                    }
                }
            } else if (buf[i] == 'e') {
                first_number_list.clearAndFree();
                if (found_first_number == false) {
                    try first_number_list.append(buf[i]);
                    try debug_first_number_list.append(buf[i]);
                    i += 1;

                    if (buf[i] == 'i') {
                        try first_number_list.append(buf[i]);
                        try debug_first_number_list.append(buf[i]);

                        if (buf[i + 1] == 'g') {
                            try first_number_list.append(buf[i + 1]);
                            try debug_first_number_list.append(buf[i + 1]);

                            if (buf[i + 2] == 'h') {
                                try first_number_list.append(buf[i + 2]);
                                try debug_first_number_list.append(buf[i + 2]);

                                if (buf[i + 3] == 't') {
                                    first_number = 8;
                                    found_first_number = true;
                                    try first_number_list.append(buf[i + 3]);
                                    try debug_first_number_list.append(buf[i + 3]);
                                    print("{s}\n", .{"found a word"});
                                    print("{s}\n", .{first_number_list.items});
                                    print("{d}\n", .{first_number});
                                    first_number_list.clearAndFree();
                                }
                            }
                        }
                    } else {
                        first_number_list.clearAndFree();
                        i += 1;
                    }
                } else {
                    last_number_list.clearAndFree();
                    try last_number_list.append(buf[i]);
                    try debug_last_number_list.append(buf[i]);
                    i += 1;

                    if (buf[i] == 'i') {
                        try last_number_list.append(buf[i]);
                        try debug_last_number_list.append(buf[i]);

                        if (buf[i + 1] == 'g') {
                            try last_number_list.append(buf[i + 1]);
                            try debug_last_number_list.append(buf[i + 1]);

                            if (buf[i + 2] == 'h') {
                                try last_number_list.append(buf[i + 2]);
                                try debug_last_number_list.append(buf[i + 2]);

                                if (buf[i + 3] == 't') {
                                    last_number = 8;
                                    found_last_number = true;
                                    try last_number_list.append(buf[i + 3]);
                                    try debug_last_number_list.append(buf[i + 3]);
                                    print("{s}\n", .{"found a number"});
                                    print("{s}\n", .{last_number_list.items});
                                    print("{d}\n", .{last_number});
                                    last_number_list.clearAndFree();
                                }
                            }
                        }
                    } else {
                        last_number_list.clearAndFree();
                    }
                }
            } else if (buf[i] == 'n') {
                first_number_list.clearAndFree();
                if (found_first_number == false) {
                    try first_number_list.append(buf[i]);
                    try debug_first_number_list.append(buf[i]);
                    i += 1;

                    if (buf[i] == 'i') {
                        try first_number_list.append(buf[i]);
                        try debug_first_number_list.append(buf[i]);

                        if (buf[i + 1] == 'n') {
                            try first_number_list.append(buf[i + 1]);
                            try debug_first_number_list.append(buf[i + 1]);

                            if (buf[i + 2] == 'e') {
                                first_number = 9;
                                found_first_number = true;
                                try first_number_list.append(buf[i + 2]);
                                try debug_first_number_list.append(buf[i + 2]);
                                print("{s}\n", .{"found a word"});
                                print("{s}\n", .{first_number_list.items});
                                print("{d}\n", .{first_number});
                                first_number_list.clearAndFree();
                            }
                        }
                    } else {
                        first_number_list.clearAndFree();
                    }
                } else {
                    last_number_list.clearAndFree();
                    try last_number_list.append(buf[i]);
                    try debug_last_number_list.append(buf[i]);
                    i += 1;

                    if (buf[i] == 'i') {
                        try last_number_list.append(buf[i]);
                        try debug_last_number_list.append(buf[i]);

                        if (buf[i + 1] == 'n') {
                            try last_number_list.append(buf[i + 1]);
                            try debug_last_number_list.append(buf[i + 1]);

                            if (buf[i + 2] == 'e') {
                                last_number = 9;
                                found_last_number = true;
                                try last_number_list.append(buf[i + 2]);
                                try debug_last_number_list.append(buf[i + 2]);
                                print("{s}\n", .{"found a number"});
                                print("{s}\n", .{last_number_list.items});
                                print("{d}\n", .{last_number});
                                last_number_list.clearAndFree();
                            }
                        }
                    } else {
                        last_number_list.clearAndFree();
                    }
                }
            } else if (first_number < 0) {
                print("{s}\n", .{"edgecase"});
                edge_case_counter += 1;
            } else if (first_number > 9) {
                print("{s}\n", .{"edgecase"});
                edge_case_counter += 1;
            } else if (last_number < 0) {
                print("{s}\n", .{"edgecase"});
                edge_case_counter += 1;
            } else if (last_number > 9) {
                print("{s}\n", .{"edgecase"});
                edge_case_counter += 1;
            } else {
                i += 1;
            }

            //print("({d} {d})", .{i, buf[i]});
        } else {
            print("{s}\n", .{"new line"});
        }

        if (found_last_number == true) {
            try last_number_list.append(last_number);
        } else {
            last_number = first_number;
            try last_number_list.append(first_number);
        }
        //print("{s}\n", .{"debug buf ="});
        //print("{s}\n", .{debug_buf});
        //print("{s}\n", .{"debug first number list ="});
        //print("{s}\n", .{debug_first_number_list.items});
        //print("{s}\n", .{"debug last number list ="});
        //print("{s}\n", .{debug_last_number_list.items});
        debug_first_number_list.clearAndFree();
        debug_last_number_list.clearAndFree();
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
    print("{s}\n", .{"first and last number ="});
    print("{d}\n", .{first_number_list.items.len});
    print("{d}\n", .{last_number_list.items.len});
    print("{s}\n", .{"The amount of edgecases are"});
    print("{d}\n", .{edge_case_counter});
    //for (first_number_list.items, last_number_list.items) |f, l| {
    //    print("{d}{d}\n", .{f, l});
    //}
}
