project('bin2c', ['c'], version: '1.1', license: 'Public Domain')

bin2c = generator(executable('bin2c', 'bin2c.c', native: true),
  output: '@PLAINNAME@.h',
  arguments: ['-o', '@OUTPUT@', '@EXTRA_ARGS@', '@INPUT@'])
