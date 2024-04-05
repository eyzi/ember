const std = @import("std");

pub fn get_bytes(filepath: [:0]const u8, allocator: std.mem.Allocator) ![]u8 {
    const file = try std.fs.cwd().openFile(filepath, .{});
    defer file.close();

    const content = try file.readToEndAlloc(allocator, (try file.stat()).size);
    defer allocator.free(content);

    return try allocator.dupe(u8, content);
}
