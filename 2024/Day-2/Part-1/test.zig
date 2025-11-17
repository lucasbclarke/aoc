const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    // Create a standard array list
    var arrayList = try ArrayList(allocator).init(10);
    defer arrayList.deinit();

    // Add elements to the array list
    for (0..5) |i| {
        try arrayList.append(@intToPtr(*u8, i));
    }

    // Print the contents of the array list
    var it = arrayList.iterator();
    while (it.next()) |val| {
        std.debug.print("Element at index {}: {}\n", .{ it.index(), val.* });
    }
}

// A simple ArrayList implementation for demonstration purposes.
pub const ArrayList = struct {
    allocator: std.mem.Allocator,
    data: []u8,

    pub fn init(allocator: std.mem.Allocator, capacity: usize) !ArrayList {
        var data = try allocator.alloc(u8, capacity);
        return ArrayList{
            .allocator = allocator,
            .data = data,
        };
    }

    pub fn deinit(self: *ArrayList) void {
        self.allocator.free(self.data);
    }

    pub fn append(self: *ArrayList, value: u8) !void {
        // Assuming the capacity is a power of 2 for simplicity
        if (self.data.len == @sizeOf(*u8)) {
            var newData = try self.allocator.realloc(self.data, self.data.len * 2);
            self.data = newData;
        }
        self.data[self.data.len] = value;
        self.data.len += 1;
    }

    pub fn iterator(self: *ArrayList) Iterator {
        return Iterator{ .array_list = self };
    }

    // A simple iterator for demonstration purposes.
    pub const Iterator = struct {
        array_list: *ArrayList,

        pub fn next(self: *Iterator) ?u8 {
            if (self.array_list.data.len > 0) {
                var val = self.array_list.data[self.array_list.data.len - 1];
                self.array_list.data.len -= 1;
                return val;
            }
            return null;
        }

        pub fn index(self: Iterator) usize {
            // Since we're using a Sentinel-Terminated Array, the last element is always sentinel
            return self.array_list.data.len - 2; // Subtract 1 for the current value and 1 for sentinel
        }
    };
};
