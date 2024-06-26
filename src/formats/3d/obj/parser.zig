const std = @import("std");
const Ember3d = @import("../../../core/types.zig").Ember3d;

pub fn parser(bytes: []u8, allocator: std.mem.Allocator) !Ember3d {
    var vertices = std.ArrayList(@Vector(3, f32)).init(allocator);
    var uvs = std.ArrayList(@Vector(2, f32)).init(allocator);
    var normals = std.ArrayList(@Vector(3, f32)).init(allocator);
    var indices = std.ArrayList(@Vector(3, u32)).init(allocator);
    defer vertices.deinit();
    defer uvs.deinit();
    defer normals.deinit();
    defer indices.deinit();

    var line_bytes = std.ArrayList(u8).init(allocator);
    defer line_bytes.deinit();

    var i_bytes: usize = 0;
    while (i_bytes < bytes.len) : (i_bytes += 1) {
        var line_char = bytes[i_bytes];

        if (line_char == '\n') {
            var words = std.mem.split(u8, line_bytes.items, " ");
            const first_word = words.next();

            if (first_word == null) {
                // skip
            } else if (std.mem.eql(u8, first_word.?, "v")) {
                const v1raw = words.next();
                const v2raw = words.next();
                const v3raw = words.next();

                const v1 = try std.fmt.parseFloat(f32, v1raw.?);
                const v2 = try std.fmt.parseFloat(f32, v2raw.?);
                const v3 = try std.fmt.parseFloat(f32, v3raw.?);

                try vertices.append(@Vector(3, f32){ v1, v2, v3 });
            } else if (std.mem.eql(u8, first_word.?, "vt")) {
                const t1raw = words.next();
                const t2raw = words.next();

                const t1 = try std.fmt.parseFloat(f32, t1raw.?);
                const t2 = try std.fmt.parseFloat(f32, t2raw.?);

                try uvs.append(@Vector(2, f32){ t1, t2 });
            } else if (std.mem.eql(u8, first_word.?, "vn")) {
                const n1raw = words.next();
                const n2raw = words.next();
                const n3raw = words.next();

                const n1 = try std.fmt.parseFloat(f32, n1raw.?);
                const n2 = try std.fmt.parseFloat(f32, n2raw.?);
                const n3 = try std.fmt.parseFloat(f32, n3raw.?);

                try normals.append(@Vector(3, f32){ n1, n2, n3 });
            } else if (std.mem.eql(u8, first_word.?, "f")) {
                while (words.next()) |index| {
                    var index_props = std.mem.split(u8, index, "/");
                    const in1raw = index_props.next();
                    const in2raw = index_props.next();
                    const in3raw = index_props.next();
                    const in1 = try std.fmt.parseInt(u32, in1raw.?, 10);
                    const in2 = try std.fmt.parseInt(u32, in2raw.?, 10);
                    const in3 = try std.fmt.parseInt(u32, in3raw.?, 10);
                    try indices.append(@Vector(3, u32){ in1 - 1, in2 - 1, in3 - 1 });
                }
            }

            line_bytes.clearAndFree();
        } else {
            try line_bytes.append(line_char);
        }
    }

    return Ember3d{
        .meta = .{
            .bytes = bytes,
        },
        .format = .OBJ,
        .vertices = try vertices.toOwnedSlice(),
        .uvs = try uvs.toOwnedSlice(),
        .normals = try normals.toOwnedSlice(),
        .indices = try indices.toOwnedSlice(),
    };
}
