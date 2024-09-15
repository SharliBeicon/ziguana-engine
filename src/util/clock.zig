const std = @import("std");

pub const Clock = struct {
    previous_time: i128,

    pub fn new() Clock {
        return Clock{ .previous_time = std.time.nanoTimestamp() };
    }

    pub fn delta(self: *Clock) i128 {
        const elapsed_time = std.time.nanoTimestamp() - self.previous_time;
        self.previous_time = std.time.nanoTimestamp();

        return elapsed_time;
    }

    pub fn split(self: *Clock) i128 {
        return std.time.nanoTimestamp() - self.previous_time;
    }
};
