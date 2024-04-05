const std = @import("std");
const EmberObject = @import("./types.zig").EmberObject;
const EmberMeta = @import("./types.zig").EmberMeta;
const EmberFormat = @import("./types.zig").EmberFormat;

const image = @import("../formats/image/_.zig");

pub fn is_format(bytes: []u8, signature: [:0]const u8) bool {
    if (bytes.len < signature.len) return false;
    return std.mem.eql(u8, signature, bytes[0..signature.len]);
}

pub fn detect_format(bytes: []u8) EmberFormat {
    if (is_format(bytes, image.bmp.signature)) {
        return .BMP;
    }
}

pub fn parse_meta(meta: EmberMeta) EmberObject {
    return switch (detect_format(meta.bytes)) {
        .BMP => EmberObject{ .image = image.bmp.parse_meta(meta) },
        else => EmberObject{.unknown},
    };
}
