project('hello', ['c'], license: 'Apache',
default_options: [
  'warning_level=2',
  'default_library=static',
])

if meson.get_compiler('c').get_id() == 'msvc' or meson.is_cross_build()
  zlib = subproject('zlib').get_variable('zlib_dep')
else
  zlib = dependency('zlib')
endif

if target_machine.system() == 'windows'
  link_args = ['-static']
else
  link_args = []
endif

exe = executable('hello',
  sources: 'hello.c',
  link_args: link_args,
  dependencies: zlib)
