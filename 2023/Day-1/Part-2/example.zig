const std = @import("std");
const print = @import("std").debug.print;

pub fn main() !void{

    const file = try std.fs.cwd().createFile(
    "txt",
    .{ .read = true, },
    );
    defer file.close();
    try file.writeAll("hi file");

    
}
