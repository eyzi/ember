const std = @import("std");
const EmberObject = @import("./types.zig").EmberObject;
const EmberFormat = @import("./types.zig").EmberFormat;
const EmberImageFormat = @import("./types.zig").EmberImageFormat;
const EmberSoundFormat = @import("./types.zig").EmberSoundFormat;
const Ember3dFormat = @import("./types.zig").Ember3dFormat;
const EmberImage = @import("./types.zig").EmberImage;
const EmberSound = @import("./types.zig").EmberSound;
const Ember3d = @import("./types.zig").Ember3d;

const parser = @import("./parser.zig");
const formats = @import("../formats/_.zig");

pub fn load(filepath: [:0]const u8, allocator: std.mem.Allocator) ![]u8 {
    const file = try std.fs.cwd().openFile(filepath, .{});
    defer file.close();
    const content = try file.readToEndAlloc(allocator, (try file.stat()).size);
    defer allocator.free(content);
    return try allocator.dupe(u8, content);
}

pub fn load_object(filepath: [:0]const u8, allocator: std.mem.Allocator) !EmberObject {
    const bytes = try load(filepath, allocator);
    const format = try formats.utils.detect_bytes_format(filepath, bytes);
    var ember_object = try parser.parse_object(format, bytes, allocator);
    switch (ember_object) {
        .image => ember_object.image.meta.file = filepath,
        .sound => ember_object.sound.meta.file = filepath,
        .@"3d" => ember_object.@"3d".meta.file = filepath,
    }
    return ember_object;
}

pub fn load_image(format: EmberImageFormat, filepath: [:0]const u8, allocator: std.mem.Allocator) !EmberImage {
    const bytes = try load(filepath, allocator);
    var image = try parser.parse_image(format, bytes, allocator);
    image.meta.file = filepath;
    return image;
}

pub fn load_sound(format: EmberSoundFormat, filepath: [:0]const u8, allocator: std.mem.Allocator) !EmberSound {
    const bytes = try load(filepath, allocator);
    var sound = try parser.parse_sound(format, bytes, allocator);
    sound.meta.file = filepath;
    return sound;
}

pub fn load_3d(format: Ember3dFormat, filepath: [:0]const u8, allocator: std.mem.Allocator) !Ember3d {
    const bytes = try load(filepath, allocator);
    var @"3d" = try parser.parse_3d(format, bytes, allocator);
    @"3d".meta.file = filepath;
    return @"3d";
}
