const std = @import("std");
const ember = @import("./_.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const sample_bytes = try ember.core.loader.get_bytes("assets/images/icon.bmp", gpa.allocator());
    defer gpa.allocator().free(sample_bytes);

    const format = ember.image.bmp.ember_format;

    var ember_meta = try ember.core.parser.parse(format, sample_bytes, gpa.allocator());
    defer ember_meta.attributes.deinit();

    const image = ember.image.bmp.parse_meta(ember_meta);
    std.debug.print("{any}\n", .{image});
}
