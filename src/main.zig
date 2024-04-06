const std = @import("std");
const ember = @import("./_.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const image = try ember.generator.generate_image("assets/images/icon.bmp", gpa.allocator());
    defer image.deallocate(gpa.allocator());

    std.debug.print("{any}\n", .{image});
}
