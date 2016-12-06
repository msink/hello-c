project('hello', ['c'], license: 'Apache',
default_options: [
  'warning_level=2',
  'default_library=static',
])

if meson.get_compiler('c').get_id() == 'msvc'
  zlib = subproject('zlib').get_variable('zlib_dep')
else
  zlib = dependency('zlib')
endif

bin2c = subproject('bin2c').get_variable('bin2c')

if target_machine.system() == 'windows'
  link_args = ['-static']
else
  link_args = []
endif

exe = executable('hello',
  sources: [
    'hello.c',
    bin2c.process('../../hello.zip', extra_args: ['-n', 'zip_file'])
  ],
  link_args: link_args,
  dependencies: zlib)
