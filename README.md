# Simplest test of [meson build](https://github.com/mesonbuild/meson)

[![Build status](https://ci.appveyor.com/api/projects/status/l2r395ew7rv55u7x?svg=true)](https://ci.appveyor.com/project/msink/hello-c)
[![Build Status](https://travis-ci.org/msink/hello-c.svg?branch=master)](https://travis-ci.org/msink/hello-c)

## on windows - testing features:
- compiling by msvc 2015 (32-bit/64-bit)
- compiling by mingw gcc (32-bit/64-bit)
- cross-compiling for linux and osx ([toolcains](https://github.com/msink/cygwin-cross-tools))
- use dependencies (zlib - external/wrap)
- use source generator (bin2c)
