const std = @import("std");
const obj = @import("../assets/object.zig");

pub const World = struct {
    updates: obj.ObjectList,
    deletions: obj.ObjectList,

    pub fn new() World {
        return World{
            .updates = undefined,
            .deletions = undefined,
        };
    }

    pub fn init(self: *World) !void {
        self.updates = try obj.ObjectList.new();
        self.deletions = try obj.ObjectList.new();
    }

    pub fn close(self: *World) void {
        self.updates.deinit();
        self.deletions.deinit();
    }

    pub fn get_all_objects(self: *World) obj.ObjectList {
        return self.updates;
    }

    pub fn objects_of_type(self: *World, obj_type: []const u8) obj.ObjectList {
        var objects = obj.ObjectList.new();
        var iter = self.updates.iterator();
        while (!iter.done()) : (iter.next()) {
            const object = iter.current() orelse break;
            if (object.type == obj_type) {
                try objects.insert(object);
            }
        }

        return objects;
    }

    pub fn insert_object(self: *World, object: *obj.Object) !void {
        try self.updates.insert(object);
    }

    pub fn delete_object(self: *World, object: *obj.Object) !void {
        try self.deletions.insert(object);
    }

    pub fn update(self: *World) !void {
        var iter = self.deletions.iterator();
        while (!iter.done()) : (iter.next()) {
            const object = iter.current() orelse break;
            _ = self.updates.remove(object);
        }

        self.deletions.clear();
        std.debug.print("World updated\n", .{});
    }
};
