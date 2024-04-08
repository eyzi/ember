const std = @import("std");

//
// Object

pub const EmberObject = union(enum) {
    image: EmberImage,
    sound: EmberSound,
    @"3d": Ember3d,
};

pub const EmberImageFormat = enum { BMP };
pub const EmberSoundFormat = enum { WAV };
pub const Ember3dFormat = enum { OBJ };
pub const EmberFormat = union(enum) {
    image: EmberImageFormat,
    sound: EmberSoundFormat,
    @"3d": Ember3dFormat,
};

//
// Meta

pub const EmberMeta = struct {
    file: ?[:0]const u8 = null,
    bytes: []u8,
    attributes: ?EmberMetaAttributes = null,

    pub fn deallocate(self: EmberMeta, allocator: std.mem.Allocator) void {
        if (self.attributes) |*attributes| {
            @constCast(attributes).deinit();
        }
        allocator.free(self.bytes);
    }
};

//
// Format

pub const EmberImagePixel = struct {
    red: u8,
    green: u8,
    blue: u8,
    alpha: u8,
};

pub const EmberImage = struct {
    meta: EmberMeta,
    format: EmberImageFormat,
    width: u32,
    height: u32,
    pixels: []EmberImagePixel,

    pub fn deallocate(self: EmberImage, allocator: std.mem.Allocator) void {
        self.meta.deallocate(allocator);
        allocator.free(self.pixels);
    }
};

pub const EmberSound = struct {
    meta: EmberMeta,
    format: EmberSoundFormat,
    n_channel: u16,
    sample_rate: u32,
    bit_depth: u16,
    data_size: usize,
    samples: []u8,

    pub fn deallocate(self: EmberSound, allocator: std.mem.Allocator) void {
        self.meta.deallocate(allocator);
        allocator.free(self.samples);
    }
};

pub const Ember3d = struct {
    meta: EmberMeta,
    format: Ember3dFormat,
    vertices: []@Vector(3, f32),
    uvs: []@Vector(2, f32),
    normals: []@Vector(3, f32),
    indices: []@Vector(3, u32),

    pub fn deallocate(self: Ember3d, allocator: std.mem.Allocator) void {
        self.meta.deallocate(allocator);
        allocator.free(self.vertices);
        allocator.free(self.uvs);
        allocator.free(self.normals);
        allocator.free(self.indices);
    }
};

//
// Attributes

pub const EmberMetaAttribute = union(enum) {
    u16: u16,
    u32: u32,
    i32: i32,
    usize: usize,
    bytes: []u8,
    unknown,

    pub fn value(comptime self: EmberMetaAttribute) std.meta.fields(EmberMetaAttribute)[@intFromEnum(self)].type {
        return @field(self, std.meta.fields(EmberMetaAttribute)[@intFromEnum(self)].name);
    }
};

pub const EmberMetaAttributes = std.StringHashMap(EmberMetaAttribute);

pub const EmberByteSequenceUnit = struct {
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

pub const EmberByteSequence = []const EmberByteSequenceUnit;
