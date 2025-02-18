const std = @import("std");

const color = @import("color.zig");
const ray = @import("ray.zig");
const vec3 = @import("vec3.zig");

fn ray_color(r: ray.Ray) color.Color {
    const unit_direction = vec3.Vec3().unit_vector(r.direction());
    const a = 0.5 * (unit_direction.y() + 1.0);
    return (1.0 - a) * color.Color().init(1.0, 1.0, 1.0) + a * color.Color().init(0.5, 0.7, 1.0);
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // Image

    const aspect_ratio = 16.0 / 9.0;
    const image_width = 400;

    // Calculate the image height, and ensure that it's at least 1.
    comptime var image_height: u32 = @as(@TypeOf(aspect_ratio), image_width) / aspect_ratio;
    image_height = if (image_height < 1) 1 else image_height;

    // Camera
    const focal_length = 1.0;
    const viewport_height = 2.0;
    const viewport_width = viewport_height * (@as(f64, image_width) / @as(f64, image_height));
    const camera_center = vec3.Point3.init(0, 0, 0);

    // Calculate the vectors across the horizontal and down the vertical viewport edges.
    const viewport_u = comptime vec3.Vec3().init(viewport_width, 0, 0);
    const viewport_v = comptime vec3.Vec3().init(0, -viewport_height, 0);

    // Calculate the horizontal and vertical delta vectors from pixel to pixel.
    const pixel_delta_u = viewport_u.div(@as(f64, image_width));
    const pixel_delta_v = viewport_v.div(@as(f64, image_height));

    // Calculate the location of the upper left pixel.
    const viewport_upper_left = camera_center - vec3.Vec3().init(0, 0, focal_length) + viewport_u / 2 - viewport_v / 2;
    const pixel00_loc = viewport_upper_left + 0.5 * (pixel_delta_u + pixel_delta_v);

    // Render
    std.debug.print("P3\n{d} {d}\n255\n", .{ image_width, image_height });

    for (0..image_height) |j| {
        for (0..image_width) |i| {
            const pixel_center = pixel00_loc + (pixel_delta_u * @as(f64, i)) + (pixel_delta_v * @as(f64, j));
            const ray_direction = pixel_center - camera_center;
            const r = ray.Ray().init(camera_center, ray_direction);

            const pixel_color = ray_color(r);
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
