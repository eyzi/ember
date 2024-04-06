const std = @import("std");
const EmberMetaAttributes = @import("../../../core/types.zig").EmberMetaAttributes;
const EmberImage = @import("../../../core/types.zig").EmberImage;

pub fn generate_image(attributes: EmberMetaAttributes, allocator: std.mem.Allocator) !EmberImage {
    return EmberImage{
        .format = .BMP,
        .width = attributes.get("width").?.u32,
        .height = @as(u32, @intCast(try std.math.absInt(attributes.get("height").?.i32))),
        .data = try allocator.dupe(u8, attributes.get("data").?.bytes),
    };
}
