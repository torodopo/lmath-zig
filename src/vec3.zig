const std = @import("std");
const testing = std.testing;

pub fn vec3(comptime T: type) type {
    return struct {
        
        data: [3]T,

        const Self = @This();

        pub inline fn zero() Self {
            return Self {
                .data = [_]T {0} ** 3
            };
        }

        pub inline fn one() Self {
            return Self {
                .data = [_]T {1} ** 3
            };
        }

        pub inline fn init(x: T, y: T, z: T) Self {
            return Self {
                .data = [_]T {x, y, z}
            };
        }

        pub fn add(self: Self, other: Self) Self {
            return Self {
                .data = [_]T {
                    self.data[0] + other.data[0],
                    self.data[1] + other.data[1],
                    self.data[2] + other.data[2]
                }
            };
        }

        pub fn add_scalar(self: Self, k: T) Self {
            return Self {
                .data = [_]T {
                    self.data[0] + k,
                    self.data[1] + k,
                    self.data[2] + k
                }
            };
        }

        pub fn sub(self: Self, other: Self) Self {
            return Self {
                .data = [_]T {
                    self.data[0] - other.data[0],
                    self.data[1] - other.data[1],
                    self.data[2] - other.data[2]
                }
            };
        }

        pub fn sub_scalar(self: Self, k: T) Self {
            return Self {
                .data = [_]T {
                    self.data[0] - k,
                    self.data[1] - k,
                    self.data[2] - k
                }
            };
        }

        pub fn dot(self: Self, other: Self) T {
            return (
                (self.data[0] * other.data[0]) + 
                (self.data[1] * other.data[1]) + 
                (self.data[2] * other.data[2])
            );
        }

        pub fn cross(self: Self, other: Self) Self {
            return Self {
                .data = [_]T {
                    self.data[1] * other.data[2] - self.data[2] * other.data[1],
                    self.data[2] * other.data[0] - self.data[0] * other.data[2],
                    self.data[0] * other.data[1] - self.data[1] * other.data[0]
                }
            };
        }

        pub fn len(self: Self) T {
            return std.math.sqrt(self.dot(self));
        }

        pub fn scale(self: Self, k: T) Self {
            return Self {
                .data = [_]T {
                    self.data[0] * k,
                    self.data[1] * k,
                    self.data[2] * k,
                }
            };
        }

        pub fn norm(self: Self) Self {
            return self.scale(1.0 / self.len());
        }
    };
}

test "Vec3 zero" {
    const v = vec3(f32).zero();

    try testing.expect(v.data[0] == 0);
    try testing.expect(v.data[1] == 0);
    try testing.expect(v.data[2] == 0);
}

test "Vec3 init" {
    const v = vec3(f32).init(1.0, 2.0, 3.0);

    try testing.expect(v.data[0] == 1.0);
    try testing.expect(v.data[1] == 2.0);
    try testing.expect(v.data[2] == 3.0);
}

test "Vec3 add" {
    const a = vec3(f32).init(1.0, 2.0, 3.0);
    const b = vec3(f32).init(3.0, 2.0, 1.0);
    const v = a.add(b);

    try testing.expect(v.data[0] == 4.0);
    try testing.expect(v.data[1] == 4.0);
    try testing.expect(v.data[2] == 4.0);
}

test "Vec3 sub" {
    const a = vec3(f32).init(1.0, 2.0, 3.0);
    const b = vec3(f32).init(3.0, 2.0, 1.0);
    const v = a.sub(b);

    try testing.expect(v.data[0] == -2.0);
    try testing.expect(v.data[1] == 0.0);
    try testing.expect(v.data[2] == 2.0);
}

test "Vec3 scale" {
    const a = vec3(f32).init(1.0, 2.0, 3.0);
    const k = 2.0;
    const v = a.scale(k);

    try testing.expect(v.data[0] == 2.0);
    try testing.expect(v.data[1] == 4.0);
    try testing.expect(v.data[2] == 6.0);
}

test "Vec3 length" {
    const a = vec3(f32).init(2.0, 2.0, 2.0);
    const x = a.len();

    try testing.expect(x == 3.46410155);
}

test "Vec3 dot" {
    const a = vec3(f32).init(1.0, 1.0, 1.0);
    const b = vec3(f32).init(1.0, 1.0, 1.0);
    const x = a.dot(b);

    try testing.expect(x == 3.0);
}

test "Vec3 cross" {
    const a = vec3(f32).init(3.0, 1.0, 2.0);
    const b = vec3(f32).init(1.0, 3.0, 2.0);
    const v = a.cross(b);

    try testing.expect(v.data[0] == -4.0);
    try testing.expect(v.data[1] == -4.0);
    try testing.expect(v.data[2] == 8.0);
}

test "Vec2 normalize" {
    const a = vec3(f32).init(1.0, 1.0, 1.0);
    const v = a.norm();

    try testing.expect(v.data[0] == 5.77350258e-01);
    try testing.expect(v.data[1] == 5.77350258e-01);
    try testing.expect(v.data[2] == 5.77350258e-01);
}