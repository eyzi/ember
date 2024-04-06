const std = @import("std");
const ember = @import("./_.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const sample_bytes = try ember.loader.get_bytes("assets/images/icon.bmp", gpa.allocator());
    defer gpa.allocator().free(sample_bytes);

    const format = ember.image.bmp.ember_format;

    var attributes = try ember.parser.parse(format, sample_bytes, gpa.allocator());
    defer attributes.deinit();

    const image = try ember.image.bmp.parse_ember_attributes(attributes);
    std.debug.print("{any}\n", .{image.data});
}
