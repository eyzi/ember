const std = @import("std");

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
