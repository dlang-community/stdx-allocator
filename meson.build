project('stdx-allocator', 'd',
    meson_version: '>=0.45',
    license: 'BSL-1.0',
    version: '2.77.2'
)

project_soversion = '0'

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
allocator_lib = library('stdx-allocator',
        [allocator_src],
        include_directories: [src_dir],
        install: true,
        version: meson.project_version(),
        soversion: project_soversion
)

pkgc.generate(name: 'stdx-allocator',
              libraries: [allocator_lib],
              subdirs: 'd/stdx-allocator',
              version: meson.project_version(),
              description: 'High-level interface for allocators for D, extracted from Phobos.'
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
    d_unittest: true,
    link_args: '-main'
)
test('test_allocator', allocator_test_exe)

#
# Install
#
install_subdir('source/stdx/', install_dir: 'include/d/stdx-allocator/')
