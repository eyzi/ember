const std = @import("std");
const EmberFormat = @import("../core/types.zig").EmberFormat;

// image signatures
const bmp_signature = @import("./image/bmp/signature.zig").signature;

// sound signatures
const wav_signature = @import("./sound/wav/signature.zig").signature;

pub fn detect_bytes_format(filename: [:0]const u8, bytes: []u8) !EmberFormat {
    _ = filename;

    if (is_format(bytes, bmp_signature)) {
        return EmberFormat{ .image = .BMP };
    } else if (is_format(bytes, wav_signature)) {
        return EmberFormat{ .sound = .WAV };
    }

    return error.FormatNotDetected;
}

pub fn is_format(bytes: []u8, signature: [:0]const u8) bool {
    if (signature.len > bytes.len) return false;
    return std.mem.eql(u8, signature, bytes[0..signature.len]);
}
