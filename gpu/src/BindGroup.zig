const Buffer = @import("Buffer.zig");
const Sampler = @import("Sampler.zig");
const TextureView = @import("TextureView.zig");

const BindGroup = @This();

/// The type erased pointer to the BindGroup implementation
/// Equal to c.WGPUBindGroup for NativeInstance.
ptr: *anyopaque,
vtable: *const VTable,

pub const VTable = struct {
    reference: fn (ptr: *anyopaque) void,
    release: fn (ptr: *anyopaque) void,
    setLabel: fn (ptr: *anyopaque, label: [:0]const u8) void,
};

pub inline fn reference(group: BindGroup) void {
    group.vtable.reference(group.ptr);
}

pub inline fn release(group: BindGroup) void {
    group.vtable.release(group.ptr);
}

pub inline fn setLabel(group: BindGroup, label: [:0]const u8) void {
    group.vtable.setLabel(group.ptr, label);
}

pub const Entry = struct {
    binding: u32,
    buffer: Buffer,
    offset: u64,
    size: u64,
    sampler: Sampler,
    texture_view: TextureView,
};

test "syntax" {
    _ = VTable;
    _ = reference;
    _ = release;
    _ = setLabel;
    _ = Entry;
}