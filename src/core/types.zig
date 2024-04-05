const std = @import("std");

// Formats

pub const EmberFormatSequence = union(enum) {
    bytes: []const EmberFormatBytes,
};

pub const EmberFormatBytes = struct {
    length: usize,
    name: [:0]const u8,
    kind: struct {
        id: enum {
            bytes,
            int,
        } = .bytes,
        signedness: std.builtin.Signedness = .unsigned,
        endian: std.builtin.Endian = .Big,
    } = .{},
};

// Meta

pub const EmberMetaInt = struct {
    signedness: std.builtin.Signedness,
    endian: std.builtin.Endian,
    bits: u16,
};

pub const EmberMetaAttribute = union(enum) {
    bytes: []u8,
    int: usize,
};

pub const EmberMeta = struct {
    bytes: []u8,
    attributes: std.StringHashMap(EmberMetaAttribute),
};

// Object

pub const EmberObject = union(enum) {
    image: EmberImage,
    sound: EmberSound,
    @"3d": Ember3d,
};

pub const EmberImage = struct {
    format: enum {
        BMP,
    },
    signature: []u8,
    filesize: usize,
    data_offset: usize,
};

pub const EmberSound = struct {
    format: enum {
        WAV,
    },
};

pub const Ember3d = struct {
    format: enum {
        OBJ,
    },
};
