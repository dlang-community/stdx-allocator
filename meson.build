project('allocator', 'd',
    meson_version: '>=0.40',
    license: 'MIT',
    version: '2.77.0'
)

project_soversion = '0'
project_version   = meson.project_version()

pkgc = import('pkgconfig')

#
# Sources
#
allocator_src = [
	'source/stdx/allocator/internal.d',
	'source/stdx/allocator/building_blocks/null_allocator.d',
	'source/stdx/allocator/building_blocks/fallback_allocator.d',
	'source/stdx/allocator/building_blocks/bitmapped_block.d',
	'source/stdx/allocator/building_blocks/stats_collector.d',
	'source/stdx/allocator/building_blocks/package.d',
	'source/stdx/allocator/building_blocks/affix_allocator.d',
	'source/stdx/allocator/building_blocks/free_list.d',
	'source/stdx/allocator/building_blocks/bucketizer.d',
	'source/stdx/allocator/building_blocks/free_tree.d',
	'source/stdx/allocator/building_blocks/kernighan_ritchie.d',
	'source/stdx/allocator/building_blocks/allocator_list.d',
	'source/stdx/allocator/building_blocks/segregator.d',
	'source/stdx/allocator/building_blocks/scoped_allocator.d',
	'source/stdx/allocator/building_blocks/region.d',
	'source/stdx/allocator/building_blocks/quantizer.d',
	'source/stdx/allocator/typed.d',
	'source/stdx/allocator/mmap_allocator.d',
	'source/stdx/allocator/showcase.d',
	'source/stdx/allocator/mallocator.d',
	'source/stdx/allocator/package.d',
	'source/stdx/allocator/common.d',
	'source/stdx/allocator/gc_allocator.d',
]

src_dir = include_directories('source/')

#
# Targets
#
allocator_lib = library('allocator',
        [allocator_src],
        include_directories: [src_dir],
        install: true,
        version: project_version,
        soversion: project_soversion
)

pkgc.generate(name: 'allocator',
              libraries: [allocator_lib],
              subdirs: 'd/allocator',
              version: project_version,
              description: 'Extracted std.experimental.allocator for usage via DUB.'
)

# for use by Vibe.d and others which embed this as subproject
allocator_dep = declare_dependency(
    link_with: [allocator_lib],
    include_directories: [src_dir]
)

#
# Tests
#
allocator_test_exe = executable('test_allocator',
    [allocator_src],
    include_directories: [src_dir],
    d_args: meson.get_compiler('d').unittest_args(),
    link_args: '-main'
)
test('test_allocator', allocator_test_exe)

#
# Install
#
install_subdir('source/stdx/', install_dir: 'include/d/stdx/')
