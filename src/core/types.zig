const std = @import("std");

// Formats

pub const EmberSignature: type = [:0]const u8;

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

pub const EmberImageFormat = enum {
    BMP,
};

pub const EmberSoundFormat = enum {
    WAV,
};

pub const Ember3dFormat = enum {
    OBJ,
};

// Meta

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
    format: EmberImageFormat,
    width: u32,
    height: u32,
    data: []u8,

    pub fn deallocate(self: EmberImage, allocator: std.mem.Allocator) void {
        allocator.free(self.data);
    }
};

pub const EmberSound = struct {
    format: EmberSoundFormat,
};

pub const Ember3d = struct {
    format: Ember3dFormat,
};
