const std = @import("std");

const Point = struct {
    x: f32,
    y: f32,
};

pub const Vector = struct {
    position: Point,

    pub fn new(x: f32, y: f32) Vector {
        return Vector{ .position = Point{ .x = x, .y = y } };
    }

    pub fn add(self: Vector, other: Vector) Vector {
        return Vector{ .position = Point{ .x = self.position.x + other.position.x, .y = self.position.y + other.position.y } };
    }

    pub fn subtract(self: Vector, other: Vector) Vector {
        return Vector{ .position = Point{ .x = self.position.x - other.position.x, .y = self.position.y - other.position.y } };
    }

    pub fn multiply(self: Vector, other: Vector) Vector {
        return Vector{ .position = Point{ .x = self.position.x * other.position.x, .y = self.position.y * other.position.y } };
    }

    pub fn divide(self: Vector, other: Vector) Vector {
        return Vector{ .position = Point{ .x = self.position.x / other.position.x, .y = self.position.y / other.position.y } };
    }

    pub fn magnitude(self: Vector) f32 {
        return std.math.sqrt(self.position.x * self.position.x + self.position.y * self.position.y);
    }

    pub fn normalize(self: Vector) Vector {
        const mag = self.magnitude();
        return Vector{ .position = Point{ .x = self.position.x / mag, .y = self.position.y / mag } };
    }

    pub fn scale(self: Vector, scalar: f32) Vector {
        return Vector{ .position = Point{ .x = self.position.x * scalar, .y = self.position.y * scalar } };
    }
};
