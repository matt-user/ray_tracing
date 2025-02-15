const std = @import("std");

const color = @import("color.zig");
const vec3 = @import("vec3.zig");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // Image
    const image_width = 256;
    const image_height = 256;

    // Render
    try stdout.print("P3\n{d} {d}\n255\n", .{ image_width, image_height });

    for (0..image_height) |j| {
        for (0..image_width) |i| {
            const r = @as(f64, @floatFromInt(i)) / @as(f64, image_width - 1);
            const g = @as(f64, @floatFromInt(j)) / @as(f64, image_height - 1);
            const b = 0.0;

            const pixel_color = vec3.Vec3().init(r, g, b);

            try color.write_color(stdout, pixel_color);
        }
    }
}

// test "simple test" {
//     var list = std.ArrayList(i32).init(std.testing.allocator);
//     defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
//     try list.append(42);
//     try std.testing.expectEqual(@as(i32, 42), list.pop());
// }
