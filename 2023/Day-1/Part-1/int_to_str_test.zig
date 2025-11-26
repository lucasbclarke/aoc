//None of this code works it was just an implamentation of a possible solution, not used in the main.zig file.

const std = @import("std");
const print = @import("std").debug.print;

const Int = usize;

var buf: [2]u8 = undefined;
var fbs = std.io.fixedBufferStream(&buf);

pub fn formatInt(int: Int, options: std.fmt.FormatOptions, writer: anytype) !void {

    const string = try std.fmt.formatInt(int, 10, .lower, options, writer);
    _ = string;
}

pub fn main() !void {
    var word: u8 = 80;

    var options = std.fmt.FormatOptions{
        .width = 1,
    };

    try formatInt(word, options, fbs.writer());
    return print("{s}\n", .{buf[0..]});
}
