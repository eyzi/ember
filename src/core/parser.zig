const std = @import("std");
const int_bytes = @import("../utils/int.zig").int_bytes;
const EmberFormatSequence = @import("./types.zig").EmberFormatSequence;
const EmberFormatBytes = @import("./types.zig").EmberFormatBytes;
const EmberMetaAttributes = @import("./types.zig").EmberMetaAttributes;
const EmberMetaAttribute = @import("./types.zig").EmberMetaAttribute;

pub fn parse(comptime ember_format: EmberFormatSequence, bytes: []u8, allocator: std.mem.Allocator) !EmberMetaAttributes {
    switch (ember_format) {
        .bytes => return try parse_bytes(ember_format.bytes, bytes, allocator),
    }
}

pub fn parse_bytes(comptime ember_bytes: []const EmberFormatBytes, bytes: []u8, allocator: std.mem.Allocator) !EmberMetaAttributes {
    var attributes = std.StringHashMap(EmberMetaAttribute).init(allocator);

    var index: usize = 0;
    inline for (ember_bytes) |ember_byte| {
        const start_index = if (ember_byte.start == .previous) index else attributes.get(ember_byte.start.from_key).?.usize;
        const end_index = start_index + if (ember_byte.length == .value) ember_byte.length.value else attributes.get(ember_byte.length.from_key).?.usize;
        const raw_value = bytes[start_index..end_index];

        // there has to be a simpler way to do this
        const value: EmberMetaAttribute = switch (ember_byte.type) {
            u16 => x: {
                const parsed_value = try int_bytes(
                    ember_byte.length.value,
                    ember_byte.signedness,
                    ember_byte.endian,
                    raw_value,
                );
                break :x EmberMetaAttribute{ .u16 = parsed_value };
            },
            u32 => x: {
                const parsed_value = try int_bytes(
                    ember_byte.length.value,
                    ember_byte.signedness,
                    ember_byte.endian,
                    raw_value,
                );
                break :x EmberMetaAttribute{ .u32 = parsed_value };
            },
            i32 => x: {
                const parsed_value = try int_bytes(
                    ember_byte.length.value,
                    ember_byte.signedness,
                    ember_byte.endian,
                    raw_value,
                );
                break :x EmberMetaAttribute{ .i32 = parsed_value };
            },
            usize => x: {
                const parsed_value = try int_bytes(
                    ember_byte.length.value,
                    ember_byte.signedness,
                    ember_byte.endian,
                    raw_value,
                );
                break :x EmberMetaAttribute{ .usize = parsed_value };
            },
            else => EmberMetaAttribute{ .bytes = raw_value },
        };

        try attributes.put(ember_byte.name, value);
        index = end_index;
    }

    return attributes;
}
