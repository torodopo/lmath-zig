const v2 = @import("vec2.zig");
const v3 = @import("vec3.zig");
const v4 = @import("vec4.zig");
const m4 = @import("mat4.zig");

pub const Vec2f = v2.vec2(f32);
pub const Vec3f = v3.vec3(f32);
pub const Vec4f = v4.vec4(f32);
pub const Mat4f = m4.mat4(f32);

pub const Vec2d = v2.vec2(f64);
pub const Vec3d = v3.vec3(f64);
pub const Vec4d = v4.vec4(f64);
pub const Mat4d = m4.mat4(f64);