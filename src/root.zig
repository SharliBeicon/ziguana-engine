const std = @import("std");
const log = @import("managers/log.zig");
const world = @import("managers/world.zig");
const obj = @import("assets/object.zig");
const Clock = @import("util/clock.zig").Clock;

const FRAME_TIME = 16_666_666; // 60 FPS

pub const Ziguana = struct {
    logger: log.Logger,
    world: world.World,

    game_over: bool,

    pub fn new() Ziguana {
        return Ziguana{ .logger = log.Logger.new(), .world = world.World.new(), .game_over = false };
    }

    pub fn init(self: *Ziguana) !void {
        try self.logger.init();
        try self.world.init();
    }

    pub fn run(self: *Ziguana) !void {
        var adjust_time: i128 = 0;
        var clock = Clock.new();
        while (!self.game_over) {
            _ = clock.delta();

            // Update game state
            // Render game state
            // Handle input

            const loop_time = clock.split();
            const intended_time = FRAME_TIME - loop_time - adjust_time;
            _ = clock.delta();
            std.time.sleep(@intCast(intended_time));

            const actual_sleep_time = clock.split();
            adjust_time = actual_sleep_time - intended_time;
            if (adjust_time < 0) {
                adjust_time = 0;
            }
        }
    }

    pub fn close(self: *Ziguana) void {
        self.game_over = true;

        self.logger.close();
        self.world.close();
    }
};
