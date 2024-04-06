const std = @import("std");
const loader = @import("./loader.zig");
const parser = @import("./parser.zig");
const EmberImage = @import("./types.zig").EmberImage;

const image_detect = @import("../formats/image/detect.zig");

pub fn generate_image(file: [:0]const u8, allocator: std.mem.Allocator) !EmberImage {
    const bytes = try loader.get_bytes(file, allocator);

    const format = image_detect.get_format(bytes) orelse return error.UnknownFormat;
    const sequence = image_detect.get_sequence(format) orelse return error.NoSequence;
    const generator = image_detect.get_generator(format) orelse return error.NoGenerator;

    var attributes = try parser.parse(sequence, bytes, allocator);
    defer attributes.deinit();

    return try generator(file, bytes, attributes, allocator);
}
