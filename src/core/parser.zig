const std = @import("std");
const EmberObject = @import("./types.zig").EmberObject;
const EmberFormat = @import("./types.zig").EmberFormat;
const EmberImageFormat = @import("./types.zig").EmberImageFormat;
const EmberSoundFormat = @import("./types.zig").EmberSoundFormat;
const Ember3dFormat = @import("./types.zig").Ember3dFormat;
const EmberImage = @import("./types.zig").EmberImage;
const EmberSound = @import("./types.zig").EmberSound;
const Ember3d = @import("./types.zig").Ember3d;

// image parsers
const bmp_parser = @import("../formats/image/bmp/parser.zig").parser;

// sound parsers
const wav_parser = @import("../formats/sound/wav/parser.zig").parser;

pub fn parse_object(format: EmberFormat, bytes: []u8, allocator: std.mem.Allocator) !EmberObject {
    return switch (format) {
        .image => |image_format| EmberObject{ .image = try parse_image(image_format, bytes, allocator) },
        .sound => |sound_format| EmberObject{ .sound = try parse_sound(sound_format, bytes, allocator) },
        .@"3d" => |@"3d_format"| EmberObject{ .@"3d" = try parse_3d(@"3d_format", bytes, allocator) },
    };
}

pub fn parse_image(format: EmberImageFormat, bytes: []u8, allocator: std.mem.Allocator) !EmberImage {
    return switch (format) {
        .BMP => bmp_parser(bytes, allocator),
    };
}

pub fn parse_sound(format: EmberSoundFormat, bytes: []u8, allocator: std.mem.Allocator) !EmberSound {
    return switch (format) {
        .WAV => wav_parser(bytes, allocator),
    };
}

pub fn parse_3d(format: Ember3dFormat, bytes: []u8, allocator: std.mem.Allocator) !Ember3d {
    _ = allocator;
    return .{
        .meta = .{
            .bytes = bytes,
        },
        .format = format,
    };
}
