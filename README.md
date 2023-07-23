# lmath-zig

Just a simple linear algebra library in zig for small gamedev projects.

## How to use 

### As a module

```zig
    pub fn build(b: *std.Build) void {
    
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // ...
    
    const lmath_module = b.addModule(
        "lmath", 
        .{ 
            .source_file = .{ 
                .path = "lib/lmath-zig/src/main.zig"
            }
        }
    );

    exe.addModule("lmath", lmath_module);

    const run_cmd = b.addRunArtifact(exe);
```
