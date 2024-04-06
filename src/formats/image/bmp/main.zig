const std = @import("std");
const EmberFormatSequence = @import("../../../core/types.zig").EmberFormatSequence;
const EmberMetaAttributes = @import("../../../core/types.zig").EmberMetaAttributes;
const EmberImage = @import("../../../core/types.zig").EmberImage;
const parser = @import("../../../core/parser.zig");

pub const signature: [:0]const u8 = "BM";

pub const ember_format = EmberFormatSequence{
    .bytes = &.{
        .{
            .length = .{ .value = 2 },
            .name = "signature",
        },
        .{
            .length = .{ .value = 4 },
            .name = "filesize",
            .type = u32,
            .signedness = .unsigned,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 4 },
            .name = "header:reserved",
        },
        .{
            .length = .{ .value = 4 },
            .name = "data-offset",
            .type = usize,
            .signedness = .unsigned,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 4 },
            .name = "info-offset",
            .type = u32,
            .signedness = .unsigned,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 4 },
            .name = "width",
            .type = u32,
            .signedness = .unsigned,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 4 },
            .name = "height",
            .type = i32,
            .signedness = .signed,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 2 },
            .name = "planes",
            .type = u16,
            .signedness = .unsigned,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 2 },
            .name = "bits-per-pixel",
            .type = u16,
            .signedness = .unsigned,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 4 },
            .name = "compression",
            .type = u32,
            .signedness = .unsigned,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 4 },
            .name = "image-size",
            .type = usize,
            .signedness = .unsigned,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 4 },
            .name = "x-pixels-per-meter",
            .type = u32,
            .signedness = .unsigned,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 4 },
            .name = "y-pixels-per-meter",
            .type = u32,
            .signedness = .unsigned,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 4 },
            .name = "colors-used",
            .type = u32,
            .signedness = .unsigned,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 4 },
            .name = "important-colors",
            .type = u32,
            .signedness = .unsigned,
            .endian = .Little,
        },
        .{
            .start = .{ .from_key = "data-offset" },
            .length = .{ .from_key = "image-size" },
            .name = "data",
        },
    },
};

pub fn parse_ember_attributes(attributes: EmberMetaAttributes) !EmberImage {
    return EmberImage{
        .format = .BMP,
        .width = attributes.get("width").?.u32,
        .height = @as(u32, @intCast(try std.math.absInt(attributes.get("height").?.i32))),
        .data = attributes.get("data").?.bytes,
    };
}
