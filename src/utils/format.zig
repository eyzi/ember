const std = @import("std");
const EmberSignature = @import("../core/types.zig").EmberSignature;

pub fn is_format(bytes: []u8, signature: EmberSignature) bool {
    if (signature.len > bytes.len) return false;
    return std.mem.eql(u8, signature, bytes[0..signature.len]);
}
