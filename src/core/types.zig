const std = @import("std");

// Formats

pub const EmberFormatSequence = union(enum) {
    bytes: []const EmberFormatBytes,
};

pub const EmberFormatBytes = struct {
    start: union(enum) {
        previous,
        from_key: [:0]const u8,
    } = .previous,
    length: union(enum) {
        value: usize,
        from_key: [:0]const u8,
    },
    name: [:0]const u8,
    type: type = []u8,
    signedness: std.builtin.Signedness = .unsigned,
    endian: std.builtin.Endian = .Big,
};

// Meta

pub const EmberMetaInt = struct {
    signedness: std.builtin.Signedness,
    endian: std.builtin.Endian,
    bits: u16,
};

pub const EmberMetaAttribute = union(enum) {
    u16: u16,
    u32: u32,
    i32: i32,
    usize: usize,
    bytes: []u8,
    unknown,
};

pub const EmberMetaAttributes = std.StringHashMap(EmberMetaAttribute);

// Object

pub const EmberImage = struct {
    format: enum {
        BMP,
    },
    width: u32,
    height: u32,
    data: []u8,
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
