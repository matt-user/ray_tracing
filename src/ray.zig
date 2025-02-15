const std = @import("std");

const vec3 = @import("vec3.zig");

pub fn Ray() type {
    return struct {
        orig: vec3.Point3,
        dir: vec3.Vec3,
        const Self = @This();

        fn init(orig: vec3.Point3, dir: vec3.Vec3) Self {
            return Self{ .orig = orig, .dir = dir };
        }

        fn origin(self: Self) vec3.Point3 {
            return self.orig;
        }

        fn direction(self: Self) vec3.Vec3 {
            return self.dir;
        }

        fn at(self: Self, t: f64) vec3.Point3 {
            return self.orig + self.dir * t;
        }
    };
}
