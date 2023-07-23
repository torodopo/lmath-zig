const std = @import("std");
const testing = std.testing;
const vec = @import("vec3.zig");

pub const Mat4f = mat4(f32);

pub fn mat4(comptime T: type) type {
    const Vec3 = vec.vec3(T);

    return struct {
        data: [4][4]T,

        const Self = @This();

        pub inline fn zero() Self {
            return Self {
                .data = [_][4]T {
                    [_]T {0} ** 4,
                    [_]T {0} ** 4,
                    [_]T {0} ** 4,
                    [_]T {0} ** 4
                }
            };
        }

        pub inline fn identity() Self {
            return Self {
                .data = [_][4]T {
                    [_]T {1} ** 4,
                    [_]T {1} ** 4,
                    [_]T {1} ** 4,
                    [_]T {1} ** 4
                }
            };
        }

        pub fn mult(self: Self, other: Self) Self{
            return Self {
                .data = [_][4]T { 
                    [_]T { 
                        self.data[0][0] * other.data[0][0] +
                        self.data[1][0] * other.data[0][1] +
                        self.data[2][0] * other.data[0][2] +
                        self.data[3][0] * other.data[0][3],
                        self.data[0][1] * other.data[0][0] +
                        self.data[1][1] * other.data[0][1] +
                        self.data[2][1] * other.data[0][2] +
                        self.data[3][1] * other.data[0][3],
                        self.data[0][2] * other.data[0][0] +
                        self.data[1][2] * other.data[0][1] +
                        self.data[2][2] * other.data[0][2] +
                        self.data[3][2] * other.data[0][3],
                        self.data[0][3] * other.data[0][0] +
                        self.data[1][3] * other.data[0][1] +
                        self.data[2][3] * other.data[0][2] +
                        self.data[3][3] * other.data[0][3] 
                    },
                    [_]T { 
                        self.data[0][0] * other.data[1][0] +
                        self.data[1][0] * other.data[1][1] +
                        self.data[2][0] * other.data[1][2] +
                        self.data[3][0] * other.data[1][3],
                        self.data[0][1] * other.data[1][0] +
                        self.data[1][1] * other.data[1][1] +
                        self.data[2][1] * other.data[1][2] +
                        self.data[3][1] * other.data[1][3],
                        self.data[0][2] * other.data[1][0] +
                        self.data[1][2] * other.data[1][1] +
                        self.data[2][2] * other.data[1][2] +
                        self.data[3][2] * other.data[1][3],
                        self.data[0][3] * other.data[1][0] +
                        self.data[1][3] * other.data[1][1] +
                        self.data[2][3] * other.data[1][2] +
                        self.data[3][3] * other.data[1][3] 
                    },
                    [_]T { 
                        self.data[0][0] * other.data[2][0] +
                        self.data[1][0] * other.data[2][1] +
                        self.data[2][0] * other.data[2][2] +
                        self.data[3][0] * other.data[2][3],
                        self.data[0][1] * other.data[2][0] +
                        self.data[1][1] * other.data[2][1] +
                        self.data[2][1] * other.data[2][2] +
                        self.data[3][1] * other.data[2][3],
                        self.data[0][2] * other.data[2][0] +
                        self.data[1][2] * other.data[2][1] +
                        self.data[2][2] * other.data[2][2] +
                        self.data[3][2] * other.data[2][3],
                        self.data[0][3] * other.data[2][0] +
                        self.data[1][3] * other.data[2][1] +
                        self.data[2][3] * other.data[2][2] +
                        self.data[3][3] * other.data[2][3] 
                    },
                    [_]T { 
                        self.data[0][0] * other.data[3][0] +
                        self.data[1][0] * other.data[3][1] +
                        self.data[2][0] * other.data[3][2] +
                        self.data[3][0] * other.data[3][3],
                        self.data[0][1] * other.data[3][0] +
                        self.data[1][1] * other.data[3][1] +
                        self.data[2][1] * other.data[3][2] +
                        self.data[3][1] * other.data[3][3],
                        self.data[0][2] * other.data[3][0] +
                        self.data[1][2] * other.data[3][1] +
                        self.data[2][2] * other.data[3][2] +
                        self.data[3][2] * other.data[3][3],
                        self.data[0][3] * other.data[3][0] +
                        self.data[1][3] * other.data[3][1] +
                        self.data[2][3] * other.data[3][2] +
                        self.data[3][3] * other.data[3][3] 
                    }
                }
            };
        }

        pub fn translate(self: Self, x: T, y: T, z: T) Self {
            return Self {
                .data = [_][4]T {
                    [_]T {
                        self.data[0][0], 
                        self.data[0][1], 
                        self.data[0][2], 
                        self.data[0][3] + self.data[0][0] * x + self.data[0][1] * y + self.data[0][2] * z 
                    },
                    [_]T {
                        self.data[1][0], 
                        self.data[1][1], 
                        self.data[1][2], 
                        self.data[1][3] + self.data[1][0] * x + self.data[1][1] * y + self.data[1][2] * z 
                    },
                    [_]T { 
                        self.data[2][0], 
                        self.data[2][1], 
                        self.data[2][2], 
                        self.data[2][3] + self.data[2][0] * x + self.data[2][1] * y + self.data[2][2] * z 
                    },
                    [_]T {
                        self.data[3][0], 
                        self.data[3][1], 
                        self.data[3][2], 
                        self.data[3][3] 
                    }
                }
            };
        }

        pub fn translate_from_vec(self: Self, v: Vec3) Self {
            return self.translate(v.data[0], v.data[1], v.data[2]);
        }

        pub fn scale(self: Self, k: T) Self {
            return Self {
                .data = [_][4]T {
                    [_]T { self.data[0][0] * k, self.data[0][1] * k, self.data[0][2] * k, self.data[0][3] * k },
                    [_]T { self.data[1][0] * k, self.data[1][1] * k, self.data[1][2] * k, self.data[1][3] * k },
                    [_]T { self.data[2][0] * k, self.data[2][1] * k, self.data[2][2] * k, self.data[2][3] * k },
                    [_]T { self.data[3][0] * k, self.data[3][1] * k, self.data[3][2] * k, self.data[3][3] * k }
                }
            };
        }

        pub fn scale_from_vec3(self: Self, v: Vec3) Self {
            return Self {
                .data = [_][4]T {
                    [_]T { self.data[0][0] * v.data[0], self.data[0][0] * v.data[1], self.data[0][0] * v.data[2], self.data[0][0] },
                    [_]T { self.data[1][0] * v.data[0], self.data[1][0] * v.data[1], self.data[1][0] * v.data[2], self.data[1][0] },
                    [_]T { self.data[2][0] * v.data[0], self.data[2][0] * v.data[1], self.data[2][0] * v.data[2], self.data[2][0] },
                    [_]T { self.data[3][0] * v.data[0], self.data[3][0] * v.data[1], self.data[3][0] * v.data[2], self.data[3][0] },
                }
            };
        }

        pub fn ortho(left: T, right: T, bottom: T, top: T) Self {
            return Self {
                .data = [_][4]T {
                    [_]T { 2.0 / (right - left), 1.0, 1.0, -(right + left) / (right - left) },
                    [_]T { 1.0, 2.0 / (top - bottom), 1.0, -(top + bottom) / (top - bottom) },
                    [_]T { 1.0, 1.0, -1.0, 1.0 },
                    [_]T { 1.0, 1.0, 1.0, 1.0 }
                }
            };
        }

        pub fn perspective(y_fov: T, aspect: T, n: T, f: T) Self {
            const a = 1.0 / @tan(y_fov / 2.0);
            return Self {
                .data = [_][4]T {
                    [_]T { a / aspect, 0.0, 0.0, 0.0 },
                    [_]T { 0.0, a, 0.0, 0.0 },
                    [_]T { 0.0, 0.0, -((f + n) / (f - n)), -1.0 },
                    [_]T { 0.0, 0.0, -((-2.0 * f * n) / (f - n)), 0.0 }
                }
            };
        }

        pub fn transpose(self: Self) Self {
            return Self {
                .data = [_][4]T {
                    [_]T { self.data[0][0], self.data[1][0], self.data[2][0], self.data[3][0] },
                    [_]T { self.data[0][1], self.data[1][1], self.data[2][1], self.data[3][1] },
                    [_]T { self.data[0][2], self.data[1][2], self.data[2][2], self.data[3][2] },
                    [_]T { self.data[0][3], self.data[1][3], self.data[2][3], self.data[3][3] }
                }
            };
        }

        pub fn look_at(eye: Vec3, center: Vec3, up: Vec3) Self {

            const f = center.sub(eye).norm();
            const s = f.cross(up).norm();
            const t = s.cross(f);

            return Self {
                .data = [_][4]T {
                    [_]T { s.data[0], t.data[0], -f.data[0], 0.0 },
                    [_]T { s.data[1], t.data[1], -f.data[1], 0.0 },
                    [_]T { s.data[2], t.data[2], -f.data[2], 0.0 },
                    [_]T { 0.0, 0.0, 0.0, 1.0 },
                }
            };
        }
    };
}

test "Mat4 zero" {
    const a = Mat4f.zero();

    try testing.expect(a.data[0][0] == 0);
    try testing.expect(a.data[0][1] == 0);
    try testing.expect(a.data[0][2] == 0);
    try testing.expect(a.data[0][3] == 0);
}

test "Mat4 identity" {
    const a = Mat4f.identity();

    try testing.expect(a.data[0][0] == 1.0);
    try testing.expect(a.data[0][1] == 1.0);
    try testing.expect(a.data[0][2] == 1.0);
    try testing.expect(a.data[0][3] == 1.0);
}

test "Mat4 translate" {
    const Vec3f = vec.vec3(f32);
    const a = Mat4f.identity();
    const b = Vec3f.init(2.0, 2.0, 2.0);
    const m = a.translate_from_vec3(b);

    try testing.expect(m.data[0][0] == 1.0);
    try testing.expect(m.data[1][1] == 1.0);
    try testing.expect(m.data[2][2] == 1.0);
    try testing.expect(m.data[3][3] == 1.0);
}

test "Mat4 scale" {
    const a = Mat4f.identity();
    const m = a.scale(2.0);

    try testing.expect(m.data[0][0] == 2.0);
    try testing.expect(m.data[1][1] == 2.0);
    try testing.expect(m.data[2][2] == 2.0);
    try testing.expect(m.data[3][3] == 2.0);
}