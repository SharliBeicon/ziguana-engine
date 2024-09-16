const std = @import("std");
const Vector = @import("vector.zig").Vector;

var id_counter: u32 = 0;

pub const Object = struct {
    id: u32,
    type: []const u8,
    position: Vector,

    pub fn new() Object {
        const new_id = id_counter;
        id_counter += 1;

        return Object{ .id = new_id, .type = "Default", .position = Vector.new(0.0, 0.0) };
    }
};

pub const ObjectList = struct {
    objects: []*Object,
    size: u32,
    count: u32,
    allocator: std.mem.Allocator,

    pub fn new() !ObjectList {
        var object_list = ObjectList{ .objects = undefined, .count = 0, .size = 20, .allocator = std.heap.page_allocator };
        object_list.objects = try object_list.allocator.alloc(*Object, object_list.size);

        return object_list;
    }

    pub fn deinit(self: *ObjectList) void {
        var iter = self.iterator();
        while (!iter.done()) : (iter.next()) {
            const obj = iter.current() orelse break;
            self.allocator.destroy(obj);
        }

        self.allocator.free(self.objects);
    }

    pub fn insert(self: *ObjectList, object: *Object) !void {
        if (self.count == self.size) {
            self.size *= 2;
            self.objects = try self.allocator.realloc(self.objects, self.size);
        }

        self.objects[self.count] = object;
        self.count += 1;
    }

    pub fn push_list(self: *ObjectList, list: *ObjectList) !void {
        self.objects = try self.allocator.realloc(self.objects, self.count + list.count);

        var iter = list.iterator();
        while (!iter.done()) : (iter.next()) {
            self.objects[self.count] = iter.current() orelse break;
            self.count += 1;
        }
    }

    pub fn remove(self: *ObjectList, object: *Object) bool {
        for (self.objects) |*obj| {
            if (obj.* == object) {
                obj.* = self.objects[self.count - 1];
                self.count -= 1;

                return true;
            }
        }

        return false;
    }

    pub fn clear(self: *ObjectList) void {
        self.count = 0;
    }

    pub fn is_empty(self: *ObjectList) bool {
        return self.count == 0;
    }

    pub fn iterator(self: *ObjectList) ObjectListIterator {
        return ObjectListIterator{
            .list = self,
            .index = 0,
        };
    }

    pub const ObjectListIterator = struct {
        list: *ObjectList,
        index: u32,

        pub fn first(self: *ObjectListIterator) void {
            self.index = 0;
        }

        pub fn next(self: *ObjectListIterator) void {
            if (self.index < self.list.count) {
                self.index += 1;
            }
        }

        pub fn done(self: *ObjectListIterator) bool {
            return self.index == self.list.count;
        }

        pub fn current(self: *ObjectListIterator) ?*Object {
            if (self.index == self.list.count) {
                return null;
            }

            return self.list.objects[self.index];
        }
    };
};
