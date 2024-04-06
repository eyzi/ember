const EmberSoundFormat = @import("../../core/types.zig").EmberSoundFormat;
const EmberFormatSequence = @import("../../core/types.zig").EmberFormatSequence;
const is_format = @import("../../utils/format.zig").is_format;

const wav = @import("./wav/_.zig");

pub fn get_format(bytes: []u8) ?EmberSoundFormat {
    if (is_format(bytes, wav.signature)) {
        return .WAV;
    }

    return null;
}

pub fn get_generator(comptime format: EmberSoundFormat) ?@TypeOf(wav.generate_sound) {
    return switch (format) {
        .WAV => wav.generate_sound,
    };
}

pub fn get_sequence(comptime format: EmberSoundFormat) ?EmberFormatSequence {
    return switch (format) {
        .WAV => wav.sequence,
    };
}
