# Ember
Media Byte Reader

## Usage

1. Add to build.zig.zon:
```
.{
    .dependencies = .{
        .ember = .{
            .url = "https://github.com/eyzi/ember/archive/003d1fe4544e29d4c6e006a0df0662b9fcee4851.tar.gz",
            .hash = "12208336cc9604ffc7de0b6a9f4a1b91d348f44065a6ecb033104e301ce54a14ef30",
        },
    },
}
```

2. Add module to your exe in build.zig
```
const ember_dep = b.dependency("ember", .{
    .target = target,
    .optimize = optimize,
});
exe.addModule("ember", ember_dep.module("ember"));  
```

3. Import in code
```
const ember = @import("ember");
```

## Image

```
const image: ember.types.EmberImage = ember.load_image(.BMP, "assets/images/icon.bmp", allocator);
defer image.deallocate(allocator);
```

`ember.types.EmberImage` has the following structure:
```
{
    meta: {
        file: [:0]const u8, // filepath
        bytes: []u8, // raw file content
    },
    format: EmberImageFormat,
    width: u32,
    height: u32,
    data: []u8, // raw bytes of image data
    pixels: []{
        red: u8,
        green: u8,
        blue: u8,
        alpha: u8,
    },
}
```

## Sound

```
const sound: ember.types.EmberSound = ember.load_sound(.WAV, "assets/sounds/completion.wav", allocator);
defer sound.deallocate(allocator);
```

`ember.types.EmberSound` has the following structure:
```
{
    meta: {
        file: [:0]const u8, // filepath
        bytes: []u8, // raw file content
    },
    format: EmberSoundFormat,
    n_channels: u16,
    sample_rate: u32,
    bit_depth: u16,
    data_size: usize,
    data: []u8, // raw bytes of samples
}
```

## Raw Bytes

```
const bytes: []u8 = ember.load(filepath, allocator);
defer allocator.free(bytes);
```
