const std = @import("std");
const ember = @import("./_.zig");

test "load" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var bytes = try ember.load("assets/images/icon.bmp", gpa.allocator());
    defer gpa.allocator().free(bytes);
    try std.testing.expect(bytes.len == 4168);
}

test "load_object" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var object = try ember.load_object("assets/images/icon.bmp", gpa.allocator());
    defer object.image.deallocate(gpa.allocator());
    try std.testing.expect(object == .image);
}

test "load_image" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var image = try ember.load_image(.BMP, "assets/images/icon.bmp", gpa.allocator());
    defer image.deallocate(gpa.allocator());
    try std.testing.expect(image.format == .BMP);
}

test "load_sound" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var sound = try ember.load_sound(.WAV, "assets/sounds/completion.wav", gpa.allocator());
    defer sound.deallocate(gpa.allocator());
    try std.testing.expect(sound.format == .WAV);
}

test "load_3d" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var model = try ember.load_3d(.OBJ, "assets/models/cube.obj", gpa.allocator());
    defer model.deallocate(gpa.allocator());
    try std.testing.expect(model.format == .OBJ);
}
