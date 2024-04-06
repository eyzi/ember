const EmberImageFormat = @import("../../core/types.zig").EmberImageFormat;
const EmberFormatSequence = @import("../../core/types.zig").EmberFormatSequence;
const is_format = @import("../../utils/format.zig").is_format;

const bmp = @import("./bmp/_.zig");

pub fn get_format(bytes: []u8) ?EmberImageFormat {
    if (is_format(bytes, bmp.signature)) {
        return .BMP;
    }

    return null;
}

pub fn get_generator(comptime format: EmberImageFormat) ?@TypeOf(bmp.generate_image) {
    return switch (format) {
        .BMP => bmp.generate_image,
    };
}

pub fn get_sequence(comptime format: EmberImageFormat) ?EmberFormatSequence {
    return switch (format) {
        .BMP => bmp.sequence,
    };
}
