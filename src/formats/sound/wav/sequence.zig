const EmberFormatSequence = @import("../../../core/types.zig").EmberFormatSequence;

pub const sequence = EmberFormatSequence{
    .bytes = &.{
        .{
            .length = .{ .value = 4 },
            .name = "signature", // "RIFF"
        },
        .{
            .length = .{ .value = 4 },
            .name = "filesize",
            .type = u32,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 4 },
            .name = "format", // "WAVE"
        },
        .{
            .length = .{ .value = 4 },
            .name = "chunk1-id", // "fmt "
        },
        .{
            .length = .{ .value = 4 },
            .name = "chunk1-size",
            .type = u32,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 2 },
            .name = "audio-format",
            .type = u16,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 2 },
            .name = "num-channels",
            .type = u16,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 4 },
            .name = "sample-rate",
            .type = u32,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 4 },
            .name = "byte-rate",
            .type = u32,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 2 },
            .name = "block-align",
            .type = u16,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 2 },
            .name = "bits-per-sample",
            .type = u16,
            .endian = .Little,
        },
        .{
            .length = .{ .value = 4 },
            .name = "data-id", // "data"
        },
        .{
            .length = .{ .value = 4 },
            .name = "data-size",
            .type = usize,
            .endian = .Little,
        },
        .{
            .length = .{ .from_key = "data-size" },
            .name = "data",
        },
    },
};
