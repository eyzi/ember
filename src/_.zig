pub const load = @import("./core/loader.zig").load;
pub const load_object = @import("./core/loader.zig").load_object;
pub const load_image = @import("./core/loader.zig").load_image;
pub const load_sound = @import("./core/loader.zig").load_sound;
pub const load_3d = @import("./core/loader.zig").load_3d;

pub const formats = @import("./formats/_.zig");

pub const types = @import("./core/types.zig");

pub const parse_object = @import("./core/parser.zig").parse_object;
pub const parse_image = @import("./core/parser.zig").parse_image;
pub const parse_sound = @import("./core/parser.zig").parse_sound;
pub const parse_3d = @import("./core/parser.zig").parse_3d;
