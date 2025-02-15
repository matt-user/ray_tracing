const std = @import("std");

const vec3 = @import("vec3.zig");

pub fn write_color(out: anytype, pixel_color: vec3.Vec3()) !void {
    const r = pixel_color.x();
    const g = pixel_color.y();
    const b = pixel_color.z();

    // Translate the [0,1] component values to the byte range [0,255].
    const rbyte: u32 = @intFromFloat(255.999 * r);
    const gbyte: u32 = @intFromFloat(255.999 * g);
    const bbyte: u32 = @intFromFloat(255.999 * b);

    // Write out the pixel's color components.
    try out.print("{d} {d} {d}\n", .{ rbyte, gbyte, bbyte });
}
