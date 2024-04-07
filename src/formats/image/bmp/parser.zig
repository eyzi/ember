const std = @import("std");
const EmberImage = @import("../../../core/types.zig").EmberImage;
const EmberImagePixel = @import("../../../core/types.zig").EmberImagePixel;
const sequencer = @import("../../../core/sequencer.zig");
const bmp_sequence = @import("./sequence.zig").sequence;

pub fn parser(bytes: []u8, allocator: std.mem.Allocator) !EmberImage {
    var attributes = try sequencer.generate_attributes_from_sequence(bmp_sequence, bytes, allocator);

    const width = attributes.get("width").?.u32;
    const height = @as(u32, @intCast(try std.math.absInt(attributes.get("height").?.i32)));

    const byte_length: usize = 4;
    const data = attributes.get("data").?.bytes;
    const pixels = try allocator.alloc(EmberImagePixel, @as(usize, @intCast(width * height)));

    var i_pixel: usize = 0;
    while (i_pixel * byte_length < data.len - byte_length) : (i_pixel += 1) {
        const data_offset = i_pixel * byte_length;
        const red = data[data_offset + 3];
        const green = data[data_offset + 2];
        const blue = data[data_offset + 1];
        const alpha = data[data_offset];

        pixels[i_pixel] = EmberImagePixel{
            .red = red,
            .green = green,
            .blue = blue,
            .alpha = alpha,
        };
    }

    return EmberImage{
        .meta = .{
            .bytes = bytes,
            .attributes = attributes,
        },
        .format = .BMP,
        .width = width,
        .height = height,
        .data = try allocator.dupe(u8, data),
        .pixels = pixels,
    };
}
