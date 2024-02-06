project('stdx-allocator', ['d'],
    meson_version: '>=1.3.1',
    license: 'BSL-1.0',
    version: 'v3.1.0'
)

project_soversion = '0'

subdir('source/')

mir_core_dep = dependency('mir-core', fallback : ['mir-core', 'mir_core_dep'])

allocator_internal_dep = declare_dependency(
    include_directories: allocator_include,
    sources: allocator_src,
    dependencies: mir_core_dep,
    version: meson.project_version(),
)

allocator_lib = library('stdx-allocator',
    dependencies: allocator_internal_dep,
    install: true,
    soversion: project_soversion,
)

#
# Tests
#
allocator_test_exe = executable(meson.project_name() + '-test',
    dependencies: allocator_internal_dep,
    d_unittest: true,
    link_args: '-main',
    link_with: allocator_lib
)

# for use by Vibe.d and others which embed this as subproject
allocator_dep = declare_dependency(
    dependencies: allocator_internal_dep,
    link_with: allocator_lib,
)

test(meson.project_name() + '-test', allocator_test_exe)
