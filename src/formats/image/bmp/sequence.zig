const EmberByteSequenceUnit = @import("../../../core/types.zig").EmberByteSequenceUnit;

pub const sequence = &[_]EmberByteSequenceUnit{
    .{
        .length = .{ .value = 2 },
        .name = "signature",
    },
    .{
        .length = .{ .value = 4 },
        .name = "filesize",
        .type = u32,
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
        .endian = .Little,
    },
    .{
        .length = .{ .value = 4 },
        .name = "info-offset",
        .type = u32,
        .endian = .Little,
    },
    .{
        .length = .{ .value = 4 },
        .name = "width",
        .type = u32,
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
        .endian = .Little,
    },
    .{
        .length = .{ .value = 2 },
        .name = "bits-per-pixel",
        .type = u16,
        .endian = .Little,
    },
    .{
        .length = .{ .value = 4 },
        .name = "compression",
        .type = u32,
        .endian = .Little,
    },
    .{
        .length = .{ .value = 4 },
        .name = "image-size",
        .type = usize,
        .endian = .Little,
    },
    .{
        .length = .{ .value = 4 },
        .name = "x-pixels-per-meter",
        .type = u32,
        .endian = .Little,
    },
    .{
        .length = .{ .value = 4 },
        .name = "y-pixels-per-meter",
        .type = u32,
        .endian = .Little,
    },
    .{
        .length = .{ .value = 4 },
        .name = "colors-used",
        .type = u32,
        .endian = .Little,
    },
    .{
        .length = .{ .value = 4 },
        .name = "important-colors",
        .type = u32,
        .endian = .Little,
    },
    .{
        .start = .{ .from_key = "data-offset" },
        .length = .{ .from_key = "image-size" },
        .name = "data",
    },
};
