@echo off
echo Compiler: %compiler%
echo Bits: %bit%

SET build=build\%compiler%-%bit%
mkdir %build%

if %compiler%==mingw (
  @echo on
  SET "PATH=C:\msys64\mingw%bit%\bin;C:\msys64\usr\bin;%PATH%"
  meson %build%
  ninja -C %build%

) else if %compiler%==msvc (
  @echo on
  if %bit%==32 call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86
  if %bit%==64 call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
  meson %build% --backend msvc2015
  dir %build%
  rem MSBuild
)
