const std = @import("std");
const LogLevel = @import("managers/log.zig").LogLevel;
const Ziguana = @import("root.zig").Ziguana;
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

    const start = std.time.nanoTimestamp();

    var object1 = obj.Object.new();
    var object2 = obj.Object.new();
    var object3 = obj.Object.new();
    var object4 = obj.Object.new();
    var object5 = obj.Object.new();
    var object6 = obj.Object.new();

    try object_list1.insert(&object1);
    try object_list1.insert(&object2);
    try object_list1.insert(&object3);

    try object_list2.insert(&object4);
    try object_list2.insert(&object5);
    try object_list2.insert(&object6);

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
