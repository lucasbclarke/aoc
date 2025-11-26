const std = @import("std");
const print = @import("std").debug.print;
const symbol: [10]u8 = .{ '%', '/', '-', '*', '#', '&', '+', '$', '@', '=' };
var iserr: bool = false;
var byte: u8 = 0;
var number: u128 = 0;
var isnumber: bool = false;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var symbols = std.ArrayList(u8).init(gpa.allocator());
    defer _ = symbols.deinit();

    var read_bytes = std.ArrayList(u8).init(gpa.allocator());
    defer _ = read_bytes.deinit();

    for (symbol) |value| {
        try symbols.append(value);
    }

    var file = try std.fs.cwd().openFile("s", .{});
    defer file.close();
    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var sym_pos = std.ArrayList(u8).init(gpa.allocator());
    defer _ = sym_pos.deinit();

    while (iserr != true) {
        const read_byte = in_stream.readByte() catch |err| {
            iserr = true;
            return err;
        };
        print("buf reader ={}\n", .{buf_reader.end});

        print("read byte = {c}\n", .{read_byte});
        if (read_byte != '\n') {
            byte += 1;
        }

        switch (read_byte) {
            '%' => {
                print("found symbol\n", .{});
                try sym_pos.append(byte);

                for (sym_pos.items) |c| {
                    print("sym_pos = {!}\n", .{c});
                }
                isnumber = false;
                number = 0;
            },
            '/' => {
                print("found symbol\n", .{});
                try sym_pos.append(byte);

                for (sym_pos.items) |c| {
                    print("sym_pos = {!}\n", .{c});
                }
                isnumber = false;
                number = 0;
            },
            '-' => {
                print("found symbol\n", .{});
                try sym_pos.append(byte);

                for (sym_pos.items) |c| {
                    print("sym_pos = {!}\n", .{c});
                }
                isnumber = false;
                number = 0;
            },
            '*' => {
                print("found symbol\n", .{});
                try sym_pos.append(byte);

                for (sym_pos.items) |c| {
                    print("sym_pos = {!}\n", .{c});
                }
                isnumber = false;
                number = 0;
            },
            '#' => {
                print("found symbol\n", .{});
                try sym_pos.append(byte);

                for (sym_pos.items) |c| {
                    print("sym_pos = {!}\n", .{c});
                }
                isnumber = false;
                number = 0;
            },
            '&' => {
                print("found symbol\n", .{});
                try sym_pos.append(byte);

                for (sym_pos.items) |c| {
                    print("sym_pos = {!}\n", .{c});
                }
                isnumber = false;
                number = 0;
            },
            '+' => {
                print("found symbol\n", .{});
                try sym_pos.append(byte);

                for (sym_pos.items) |c| {
                    print("sym_pos = {!}\n", .{c});
                }
                isnumber = false;
                number = 0;
            },
            '$' => {
                print("found symbol\n", .{});
                try sym_pos.append(byte);

                for (sym_pos.items) |c| {
                    print("sym_pos = {!}\n", .{c});
                }
                isnumber = false;
                number = 0;
            },
            '@' => {
                print("found symbol\n", .{});
                try sym_pos.append(byte);

                for (sym_pos.items) |c| {
                    print("sym_pos = {!}\n", .{c});
                }
                isnumber = false;
                number = 0;
            },
            '=' => {
                print("found symbol\n", .{});
                try sym_pos.append(byte);

                for (sym_pos.items) |c| {
                    print("sym_pos = {!}\n", .{c});
                }
                isnumber = false;
                number = 0;
            },
            else => {},
        }

        if (byte < buf_reader.end - 1) {
            iserr = true;
        }
    }

    iserr = false;
    byte = 0;

    while (iserr != true) {
        const read_byte = try in_stream.readByte();
        print("read byte = {c}\n", .{read_byte});
        if (read_byte != '\n') {
            byte += 1;
        }

        switch (read_byte) {
            '.' => {
                isnumber = false;
                number = 0;
            },
            '0' => {
                isnumber = true;
                number = (number * 10);
            },
            '1' => {
                isnumber = true;
                number = (number * 10) + 1;
            },
            '2' => {
                isnumber = true;
                number = (number * 10) + 2;
            },
            '3' => {
                isnumber = true;
                number = (number * 10) + 3;
            },
            '4' => {
                isnumber = true;
                number = (number * 10) + 4;
            },
            '5' => {
                isnumber = true;
                number = (number * 10) + 5;
            },
            '6' => {
                isnumber = true;
                number = (number * 10) + 6;
            },
            '7' => {
                isnumber = true;
                number = (number * 10) + 7;
            },
            '8' => {
                isnumber = true;
                number = (number * 10) + 8;
            },
            '9' => {
                isnumber = true;
                number = (number * 10) + 9;
            },
            else => {},
        }

        if (isnumber == true) {
            print("number = {d}\n", .{number});
        }
    }
}
