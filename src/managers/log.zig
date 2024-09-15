const std = @import("std");
const cwd: std.fs.Dir = std.fs.cwd();

pub const LogLevel = enum {
    Debug,
    Info,
    Warning,
    Error,
    Critical,

    pub fn toSlice(self: LogLevel) []const u8 {
        switch (self) {
            LogLevel.Debug => return "DEBUG",
            LogLevel.Info => return "INFO",
            LogLevel.Warning => return "WARNING",
            LogLevel.Error => return "ERROR",
            LogLevel.Critical => return "CRITICAL",
        }
    }
};

pub const Logger = struct {
    dir: std.fs.Dir,
    file: std.fs.File,

    pub fn new() Logger {
        return Logger{ .dir = undefined, .file = undefined };
    }

    pub fn init(self: *Logger) !void {
        const output_dir: std.fs.Dir = try cwd.openDir("./", .{});
        const file: std.fs.File = try output_dir.createFile("zigling.txt", .{});

        self.dir = output_dir;
        self.file = file;
    }

    pub fn write(self: *Logger, level: LogLevel, message: []const u8) !usize {
        const separator = " -- ";
        const total_len = level.toSlice().len + separator.len + message.len;

        var buffer: [512]u8 = undefined;
        var writer = std.io.fixedBufferStream(&buffer);

        _ = try writer.write(level.toSlice());
        _ = try writer.write(separator);
        _ = try writer.write(message);

        return try self.file.write(buffer[0..total_len]);
    }

    pub fn close(self: *Logger) void {
        self.file.close();
        self.dir.close();
    }
};
