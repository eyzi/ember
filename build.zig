const builtin = @import("builtin");
const std = @import("std");

pub fn build(b: *std.Build) !void {
    const exe = try create_executable(b);
    create_run_command(b, exe);
}

fn create_executable(b: *std.Build) !*std.Build.Step.Compile {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const exe = b.addExecutable(.{
        .name = "ember",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe);
    return exe;
}

fn create_run_command(b: *std.Build, exe: *std.Build.Step.Compile) void {
    const run_cmd = b.addRunArtifact(exe);
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run app");
    run_step.dependOn(&run_cmd.step);
}
