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
pub const EmberMeta = struct {
    file: [:0]const u8,
    bytes: []u8,
    // attributes: EmberMetaAttributes,

    pub fn deallocate(self: EmberMeta, allocator: std.mem.Allocator) void {
        // self.meta.attributes.deinit();
        allocator.free(self.bytes);
    }
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
    meta: EmberMeta,
    format: EmberImageFormat,
    width: u32,
    height: u32,
    data: []u8,

    pub fn deallocate(self: EmberImage, allocator: std.mem.Allocator) void {
        self.meta.deallocate(allocator);
        allocator.free(self.data);
    }
};

pub const EmberSound = struct {
    meta: EmberMeta,
    format: EmberSoundFormat,
    n_channel: u16,
    sample_rate: u32,
    bit_depth: u16,
    data: []u8,

    pub fn deallocate(self: EmberSound, allocator: std.mem.Allocator) void {
        self.meta.deallocate(allocator);
        allocator.free(self.data);
    }
};

pub const Ember3d = struct {
    meta: EmberMeta,
    format: Ember3dFormat,
};
