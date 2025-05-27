const std = @import("std");
const print = @import("std").debug.print;

const gears: []const u8 = &[_]u8{ '*', '$', '#', '+', '/', '%', '@', '&', '=', '-', };
var line_num: u8 = 1;

pub fn main() !void {
    const file = try std.fs.cwd().openFile("s", .{});

    var buffer: [1024]u8 = undefined;
    
    while (try file.reader().readUntilDelimiterOrEof(&buffer, '\n')) |line| {
          var gear_iter = std.mem.splitAny(u8, line, gears);
          print("line = {s}\n", .{line});
          while (gear_iter.next()) |gear| { 	//the same as while (gear_iter.next() != null) {}
              if (gear_iter.index) |index| { 	//the same as if (gear_iter.index != null) {}
                  print("x pos = {d} y pos = {d}\n", .{index, line_num});
                  print("\n", .{});
                  print ("gear = {s}\n", .{gear});
                  print("\n", .{});
              }

          }

          line_num += 1;
    }
}
