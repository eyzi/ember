const std = @import("std");

const EmberFormatSequence = @import("./types.zig").EmberFormatSequence;
const EmberFormatBytes = @import("./types.zig").EmberFormatBytes;
const EmberMetaAttribute = @import("./types.zig").EmberMetaAttribute;
const EmberMeta = @import("./types.zig").EmberMeta;

pub fn parse(comptime ember_format: EmberFormatSequence, bytes: []u8, allocator: std.mem.Allocator) !EmberMeta {
    switch (ember_format) {
        .bytes => return try parse_bytes(ember_format.bytes, bytes, allocator),
    }
}

pub fn parse_bytes(comptime ember_bytes: []const EmberFormatBytes, bytes: []u8, allocator: std.mem.Allocator) !EmberMeta {
    var attributes = std.StringHashMap(EmberMetaAttribute).init(allocator);

    var index: usize = 0;
    inline for (ember_bytes) |ember_byte| {
        const end_index = index + ember_byte.length;
        const raw_value = bytes[index..end_index];

        const value: EmberMetaAttribute = switch (ember_byte.kind.id) {
            .bytes => EmberMetaAttribute{ .bytes = raw_value },
            .int => x: {
                break :x EmberMetaAttribute{
                    .int = try int_bytes(
                        ember_byte.length,
                        ember_byte.kind.signedness,
                        ember_byte.kind.endian,
                        raw_value,
                    ),
                };
            },
        };

        try attributes.put(ember_byte.name, value);

        index = end_index;
    }

    return EmberMeta{
        .bytes = bytes,
        .attributes = attributes,
    };
}

pub fn int_bytes(
    comptime byte_length: comptime_int,
    comptime signed: std.builtin.Signedness,
    comptime endian: std.builtin.Endian,
    bytes: []const u8,
) !@Type(.{ .Int = .{ .signedness = signed, .bits = byte_length * 8 } }) {
    if (byte_length > bytes.len) return error.UnprocessableBytes;
    const int_type = @Type(.{ .Int = .{ .signedness = signed, .bits = byte_length * 8 } });
    return std.mem.toNative(int_type, std.mem.bytesToValue(int_type, bytes[0..byte_length]), endian);
}
