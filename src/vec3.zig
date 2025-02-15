const std = @import("std");

const math = std.math;

const expectEqual = std.testing.expectEqual;

pub fn Vec3() type {
    return struct {
        e: [3]f64,
        const Self = @This();

        pub fn init(e0: f64, e1: f64, e2: f64) Self {
            return Self{ .e = [3]f64{ e0, e1, e2 } };
        }

        pub fn x(self: Self) f64 {
            return self.e[0];
        }

        pub fn y(self: Self) f64 {
            return self.e[1];
        }

        pub fn z(self: Self) f64 {
            return self.e[2];
        }

        pub fn length(comptime self: Self) f64 {
            return math.sqrt(self.length_squared());
        }

        pub fn length_squared(self: Self) f64 {
            return (self.e[0] * self.e[0]) + (self.e[1] * self.e[1]) + (self.e[2] * self.e[2]);
        }

        pub fn print(comptime self: Self) void {
            std.debug.print("{d} {d} {d}\n", .{ self.e[0], self.e[1], self.e[2] });
        }

        pub fn add(comptime self: Self, comptime other: Self) Self {
            return Self{ self.e[0] + other.e[0], self.e[1] + other.e[1], self.e[2] + other.e[2] };
        }

        pub fn sub(comptime self: Self, comptime other: Self) Self {
            return Self{ self.e[0] - other.e[0], self.e[1] - other.e[1], self.e[2] - other.e[2] };
        }

        pub fn mul(comptime self: Self, other: anytype) Self {
            if (@TypeOf(other) == Vec3) {
                return Self{ self.e[0] * other.e[0], self.e[1] * other.e[1], self.e[2] * other.e[2] };
            }

            return Self{ self.e[0] * @as(f64, other), self.e[1] * @as(f64, other), self.e[2] * @as(f64, other) };
        }

        pub fn div(comptime self: Self, comptime other: Self) Self {
            return Self{ self.e[0] / other.e[0], self.e[1] / other.e[1], self.e[2] / other.e[2] };
        }

        pub fn dot(comptime self: Self, comptime other: Self) f64 {
            return (self.e[0] * other.e[0]) + (self.e[1] * other.e[1]) + (self.e[2] * other.e[2]);
        }

        pub fn cross(comptime self: Self, comptime other: Self) Self {
            return Self{
                self.e[1] * other.e[2] - self.e[2] * other.e[1],
                self.e[2] * other.e[0] - self.e[0] * other.e[2],
                self.e[0] * other.e[1] - self.e[1] * other.e[0],
            };
        }

        pub fn unit_vector(comptime self: Self) Self {
            return self / self.length();
        }
    };
}

// Point3 is just a Vec3, but useful for geometric clarity in the code.
const Point3 = Vec3;
