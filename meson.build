project('hello', ['c'], default_options: [
  'warning_level=2',
  'default_library=static',
])

if meson.get_compiler('c').get_id() == 'msvc'
  zlib = subproject('zlib').get_variable('zlib_dep')
else
  zlib = dependency('zlib', static: true)
endif

exe = executable('hello', sources: 'hello.c',
  dependencies: zlib)
