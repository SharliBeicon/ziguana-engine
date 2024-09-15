const std = @import("std");
const LogLevel = @import("managers/log.zig").LogLevel;
const Ziguana = @import("root.zig").Ziguana;
const Vector = @import("geometry/vector.zig").Vector;

pub fn main() !void {
    var ziguana = Ziguana.new();
    defer ziguana.close();

    try ziguana.init();
    ziguana.run();
}
