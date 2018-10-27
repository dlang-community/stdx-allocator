project('stdx-allocator', 'd',
    meson_version: '>=0.45',
    license: 'BSL-1.0',
    version: '3.0.1'
)

project_soversion = '0'

mir_core_dep = dependency('mir-core', fallback : ['mir-core', 'mir_core_dep'])

required_deps = [mir_core_dep]

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
	soversion: project_soversion,
	dependencies: required_deps,
)

#
# Tests
#
allocator_test_exe = executable(meson.project_name() + '-test',
    allocator_src,
    include_directories: src_dir,
    d_unittest: true,
    link_args: '-main',
	dependencies: required_deps,

)

# for use by Vibe.d and others which embed this as subproject
allocator_dep = declare_dependency(
    link_with: allocator_lib,
    include_directories: src_dir,
    dependencies: required_deps,
)

#
# Install
#
install_subdir('source/stdx/', install_dir: 'include/d/stdx-allocator/')


pkgc.generate(name: 'stdx-allocator',
	libraries: allocator_lib,
    subdirs: 'd/' + meson.project_name(),
	version: meson.project_version(),
	description: 'High-level interface for allocators for D, extracted from Phobos.'
)

test(meson.project_name() + '-test', allocator_test_exe)
