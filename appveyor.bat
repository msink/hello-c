@echo off
echo Compiler: %compiler%
echo Bits: %bit%

set PATH=%PATH%;C:\msys64\usr\bin
set build=build\%compiler%-%bit%
mkdir %build%

if %compiler%==mingw (
  @echo on
  SET PATH=C:\msys64\mingw%bit%\bin;%PATH%
  meson %build%
  ninja -C %build%
  file %build%\hello
  %build%\hello

) else if %compiler%==msvc (
  @echo on
  if %bit%==32 call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86
  if %bit%==64 call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
  meson %build% --backend vs2015
  MSBuild %build%\hello.sln
  file %build%\hello
  %build%\hello

)
