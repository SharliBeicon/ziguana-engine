const std = @import("std");
const LogLevel = @import("managers/log.zig").LogLevel;
const Ziguana = @import("root.zig").Ziguana;
const create_heap = @import("root.zig").create_heap;
const Vector = @import("assets/vector.zig").Vector;
const obj = @import("assets/object.zig");
pub fn main() !void {
    var ziguana = Ziguana.new();
    defer ziguana.close();

    try ziguana.init();

    var object_list1 = try obj.ObjectList.new();
    defer object_list1.deinit();

    var object_list2 = try obj.ObjectList.new();
    defer object_list2.deinit();

    var allocator = std.heap.page_allocator;

    const start = std.time.nanoTimestamp();

    var id_counter: u32 = 0;
    while (id_counter < 1_000_000) : (id_counter += 1) {
        const object = try allocator.create(obj.Object);
        object.* = obj.Object.new();

        try object_list1.insert(object);
    }

    id_counter = 0;
    while (id_counter < 1_000_000) : (id_counter += 1) {
        const object = try allocator.create(obj.Object);
        object.* = obj.Object.new();

        try object_list2.insert(object);
    }

    try object_list1.push_list(&object_list2);

    var iter = object_list1.iterator();
    while (!iter.done()) : (iter.next()) {
        std.debug.print("Object ID: {}\n", .{iter.current().?.id});
    }
    const end = std.time.nanoTimestamp();

    const elapsed: f64 = @as(f64, @floatFromInt(end - start)) / 1_000_000.0;

    std.debug.print("Elapsed time: {} ms\n", .{elapsed});

    // ziguana.run();
}
