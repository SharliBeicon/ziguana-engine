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

    try ziguana.run();
}
