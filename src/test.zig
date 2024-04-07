const std = @import("std");
const ember = @import("./_.zig");

test "load" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var bytes = try ember.load("assets/images/icon.bmp", gpa.allocator());
    defer gpa.allocator().free(bytes);
}

test "load_object" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var object = try ember.load_object("assets/images/icon.bmp", gpa.allocator());
    defer object.image.deallocate(gpa.allocator());
}

test "load_image" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var image = try ember.load_image(.BMP, "assets/images/icon.bmp", gpa.allocator());
    defer image.deallocate(gpa.allocator());
}

test "load_sound" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var sound = try ember.load_sound(.WAV, "assets/sounds/completion.wav", gpa.allocator());
    defer sound.deallocate(gpa.allocator());
}

// how to test?
