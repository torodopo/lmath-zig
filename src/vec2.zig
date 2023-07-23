const std = @import("std");
const testing = std.testing;

pub fn vec2(comptime T: type) type {
    return struct {
        
        data: [2]T,

        const Self = @This();

        pub inline fn zero() Self {
            return Self {
                .data = [_]T {0} ** 2
            };
        }

        pub inline fn one() Self {
            return Self {
                .data = [_]T {1} ** 2
            };
        }

        pub fn init(x: T, y: T) Self {
            return Self {
                .data = [_]T {x, y}
            };
        }

        pub fn add(self: Self, other: Self) Self {
            return Self {
                .data = [_]T {
                    self.data[0] + other.data[0],
                    self.data[1] + other.data[1]
                }
            };
        }

        pub fn add_scalar(self: Self, k: T) Self {
            return Self {
                .data = [_]T {
                    self.data[0] + k,
                    self.data[1] + k
                }
            };
        }

        pub fn sub(self: Self, other: Self) Self {
            return Self {
                .data = [_]T {
                    self.data[0] - other.data[0],
                    self.data[1] - other.data[1]
                }
            };
        }

        pub fn sub_scalar(self: Self, k: T) Self {
            return Self {
                .data = [_]T {
                    self.data[0] - k,
                    self.data[1] - k
                }
            };
        }

        pub fn dot(self: Self, other: Self) T {
            return (self.data[0] * other.data[0]) + (self.data[1] * other.data[1]);
        }

        pub fn cross(self: Self, other: Self) T {
            return (self.data[0] * other.data[1]) + (self.data[1] * other.data[0]);
        }

        pub fn len(self: Self) T {
            return std.math.sqrt(self.dot(self));
        }

        pub fn scale(self: Self, k: T) Self {
            return Self {
                .data = [_]T {
                    self.data[0] * k,
                    self.data[1] * k
                }
            };
        }

        pub fn norm(self: Self) Self {
            return self.scale(1.0 / self.len());
        }

        pub fn distance(self: Self, other: Self) T {
            return std.math.sqrt(
                std.math.pow(T, self.data[0] - other.data[0]) +
                std.math.pow(T, self.data[1] - other.data[1])
            );
        }
    };
}

test "Vec2 zero" {
    const v = vec2(f32).zero();

    try testing.expect(v.data[0] == 0);
    try testing.expect(v.data[1] == 0);
}

test "Vec2 init" {
    const v = vec2(f32).init(1.0, 2.0);

    try testing.expect(v.data[0] == 1.0);
    try testing.expect(v.data[1] == 2.0);
}

test "Vec2 add" {
    const a = vec2(f32).init(2.0, 2.0);
    const b = vec2(f32).init(3.0, 3.0);
    const v = a.add(b);

    try testing.expect(v.data[0] == 5.0);
    try testing.expect(v.data[1] == 5.0);
}

test "Vec2 sub" {
    const a = vec2(f32).init(2.0, 2.0);
    const b = vec2(f32).init(3.0, 3.0);
    const v = a.sub(b);
    
    try testing.expect(v.data[0] == -1.0); 
    try testing.expect(v.data[1] == -1.0);
}

test "Vec2 scale" {
    const a = vec2(f32).init(2.0, 2.0);
    const k = 2.0;
    const v = a.scale(k);

    try testing.expect(v.data[0] == 4.0);
    try testing.expect(v.data[1] == 4.0);
}

test "Vec2 length" {
    const a = vec2(f32).init(2.0, 2.0);
    const x = a.len();

    try testing.expect(x == 2.82842707);
}

test "Vec2 dot" {
    const a = vec2(f32).init(1.0, 1.0);
    const b = vec2(f32).init(1.0, 1.0);
    const x = a.dot(b);

    try testing.expect(x == 2.0);
}

test "Vec2 cross" {
    const a = vec2(f32).init(1.0, 1.0);
    const b = vec2(f32).init(1.0, 1.0);
    const x = a.cross(b);

    try testing.expect(x == 2.0);
}

test "Vec2 normalize" {
    const a = vec2(f32).init(1.0, 1.0);
    const v = a.norm();

    try testing.expect(v.data[0] == 7.07106769e-01);
    try testing.expect(v.data[1] == 7.07106769e-01);
}