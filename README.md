stdx.allocator
===============

Extracted `std.experimental.allocator` for usage via DUB.

This compatibility snapshot contains all 24 allocator modules from
[Phobos commit `187736735`](https://github.com/dlang/phobos/commit/1877367354fadf001365292d74e39ffd15c21bbc).
The source changes replace the `std.experimental.allocator` module namespace
with `stdx.allocator` and adjust `package(std)` visibility to `package(stdx)`.
Copyright and license notices are retained.

This snapshot precedes the changes that make Region allocators noncopyable and
restrict `deallocateAll()` to `@system`. It also retains `GCAllocator.deallocate`
and `GCAllocator.reallocate`, and includes `GCHeapMallocator`.
It preserves the old API, including its safety limitations; it does not apply
those planned fixes.

## Migration

Add a dependency on `stdx-allocator` and replace allocator imports beginning
with `std.experimental.allocator` with `stdx.allocator`. Use the same namespace
consistently for composed allocators and typed helpers.

The proposed release is 4.0.0 because this snapshot differs from both the
historical 2.77.x API and the BetterC fork in 3.x. A release tag and DUB version
must be published before users can pin it. Existing published versions remain
available for projects that depend on those APIs. This snapshot depends on
Phobos and does not provide the BetterC support of the 3.x fork.

## Verification

The initial compiler baseline for this snapshot is DMD 2.113.0. Older compiler
support has not been established.

```sh
dub test
dub test --build=unittest-release
```

The unittest configuration enables the upstream `StdUnittest` allocator tests.
