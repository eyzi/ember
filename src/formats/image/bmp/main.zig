const std = @import("std");
const EmberFormatSequence = @import("../../../core/types.zig").EmberFormatSequence;
const EmberMeta = @import("../../../core/types.zig").EmberMeta;
const EmberImage = @import("../../../core/types.zig").EmberImage;
const parser = @import("../../../core/parser.zig");

pub const signature: [:0]const u8 = "BM";

pub const ember_format = EmberFormatSequence{
    .bytes = &.{
        .{ .length = 2, .name = "signature" },
        .{
            .length = 4,
            .name = "filesize",
            .kind = .{
                .id = .int,
                .signedness = .unsigned,
                .endian = .Little,
            },
        },
        .{ .length = 4, .name = "header:reserved" },
        .{
            .length = 4,
            .name = "data-offset",
            .kind = .{
                .id = .int,
                .signedness = .unsigned,
                .endian = .Little,
            },
        },
    },
};

pub fn parse_meta(meta: EmberMeta) !EmberImage {
    return EmberImage{
        .format = .BMP,
        .signature = meta.attributes.get("signature").?.bytes,
        .filesize = meta.attributes.get("filesize").?.int,
        .data_offset = meta.attributes.get("data-offset").?.int,
    };
}
