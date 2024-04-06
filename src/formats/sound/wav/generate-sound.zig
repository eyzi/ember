const std = @import("std");
const EmberMetaAttributes = @import("../../../core/types.zig").EmberMetaAttributes;
const EmberSound = @import("../../../core/types.zig").EmberSound;

pub fn generate_sound(file: [:0]const u8, bytes: []u8, attributes: EmberMetaAttributes, allocator: std.mem.Allocator) !EmberSound {
    return EmberSound{
        .meta = .{
            .file = file,
            .bytes = bytes,
            // .attributes = attributes,
        },
        .format = .WAV,
        .n_channel = attributes.get("num-channels").?.u16,
        .sample_rate = attributes.get("sample-rate").?.u32,
        .bit_depth = attributes.get("bits-per-sample").?.u16,
        .data = try allocator.dupe(u8, attributes.get("data").?.bytes),
    };
}
