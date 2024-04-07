const std = @import("std");
const EmberSound = @import("../../../core/types.zig").EmberSound;
const sequencer = @import("../../../core/sequencer.zig");
const wav_sequence = @import("./sequence.zig").sequence;

pub fn parser(bytes: []u8, allocator: std.mem.Allocator) !EmberSound {
    var attributes = try sequencer.generate_attributes_from_sequence(wav_sequence, bytes, allocator);
    return EmberSound{
        .meta = .{
            .bytes = bytes,
            .attributes = attributes,
        },
        .format = .WAV,
        .n_channel = attributes.get("num-channels").?.u16,
        .sample_rate = attributes.get("sample-rate").?.u32,
        .bit_depth = attributes.get("bits-per-sample").?.u16,
        .data_size = attributes.get("data-size").?.usize,
        .data = try allocator.dupe(u8, attributes.get("data").?.bytes),
    };
}
