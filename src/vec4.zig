const std = @import("std");
const testing = std.testing;

pub fn vec4(comptime T: type) type {
    return struct {
        
        data: [4]T,

        const Self = @This();

        pub inline fn zero() Self {
            return Self {
                .data = [_]T {0} ** 4
            };
        }

        pub inline fn one() Self {
            return Self {
                .data = [_]T {1} ** 4
            };
        }

        pub inline fn init(x: T, y: T, z: T, w: T) Self {
            return Self {
                .data = [_]T {x, y, z, w}
            };
        }

        pub fn add(self: Self, other: Self) Self {
            return Self {
                .data = [_]T {
                    self.data[0] + other.data[0],
                    self.data[1] + other.data[1],
                    self.data[2] + other.data[2],
                    self.data[3] + other.data[3]
                }
            };
        }

        pub fn add_scalar(self: Self, k: T) Self {
            return Self {
                .data = [_]T {
                    self.data[0] + k,
                    self.data[1] + k,
                    self.data[2] + k,
                    self.data[3] + k
                }
            };
        }

        pub fn sub(self: Self, other: Self) Self {
            return Self {
                .data = [_]T {
                    self.data[0] - other.data[0],
                    self.data[1] - other.data[1],
                    self.data[2] - other.data[2],
                    self.data[3] - other.data[3]
                }
            };
        }

        pub fn sub_scalar(self: Self, k: T) Self {
            return Self {
                .data = [_]T {
                    self.data[0] - k,
                    self.data[1] - k,
                    self.data[2] - k,
                    self.data[3] - k
                }
            };
        }

        pub fn dot(self: Self, other: Self) T {
            return (
                (self.data[0] * other.data[0]) + 
                (self.data[1] * other.data[1]) + 
                (self.data[2] * other.data[2]) + 
                (self.data[3] * other.data[3])
            );
        }

        pub fn cross(self: Self, other: Self) Self {
            return Self {
                .data = []T {
                    self.data[1] * other.data[2] - self.data[2] * other.data[1],
                    self.data[2] * other.data[0] - self.data[0] * other.data[2],
                    self.data[0] * other.data[1] - self.data[1] * other.data[0],
                    1.0
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
                    self.data[3] * k
                }
            };
        }

        pub fn norm(self: Self) Self {
            return self.scale(1.0 / self.len());
        }
    };
}

test "Vec4 zero" {
    const v = vec4(f32).zero();
    try testing.expect(v.data[0] == 0.0);
    try testing.expect(v.data[1] == 0.0);
    try testing.expect(v.data[2] == 0.0);
    try testing.expect(v.data[3] == 0.0);
}

test "Vec4 init" {
    const v = vec4(f32).init(1.0, 2.0, 3.0, 4.0);
    
    try testing.expect(v.data[0] == 1.0);
    try testing.expect(v.data[1] == 2.0);
    try testing.expect(v.data[2] == 3.0);
    try testing.expect(v.data[3] == 4.0);
}