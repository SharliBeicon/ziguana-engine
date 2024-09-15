const std = @import("std");

const Point = struct {
    x: f32,
    y: f32,
};

pub const Vector = struct {
    coordinates: Point,

    pub fn new(x: f32, y: f32) Vector {
        return Vector{ .coordinates = Point{ .x = x, .y = y } };
    }

    pub fn add(self: Vector, other: Vector) Vector {
        return Vector{ .coordinates = Point{ .x = self.coordinates.x + other.coordinates.x, .y = self.coordinates.y + other.coordinates.y } };
    }

    pub fn subtract(self: Vector, other: Vector) Vector {
        return Vector{ .coordinates = Point{ .x = self.coordinates.x - other.coordinates.x, .y = self.coordinates.y - other.coordinates.y } };
    }

    pub fn multiply(self: Vector, other: Vector) Vector {
        return Vector{ .coordinates = Point{ .x = self.coordinates.x * other.coordinates.x, .y = self.coordinates.y * other.coordinates.y } };
    }

    pub fn divide(self: Vector, other: Vector) Vector {
        return Vector{ .coordinates = Point{ .x = self.coordinates.x / other.coordinates.x, .y = self.coordinates.y / other.coordinates.y } };
    }

    pub fn magnitude(self: Vector) f32 {
        return std.math.sqrt(self.coordinates.x * self.coordinates.x + self.coordinates.y * self.coordinates.y);
    }

    pub fn normalize(self: Vector) Vector {
        const mag = self.magnitude();
        return Vector{ .coordinates = Point{ .x = self.coordinates.x / mag, .y = self.coordinates.y / mag } };
    }

    pub fn scale(self: Vector, scalar: f32) Vector {
        return Vector{ .coordinates = Point{ .x = self.coordinates.x * scalar, .y = self.coordinates.y * scalar } };
    }
};
