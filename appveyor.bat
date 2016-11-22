@echo off
echo.
echo Compiler: %compiler%
echo Bits: %bit%
echo.

set "PATH=%PATH%;C:\msys64\usr\bin"
set build=build\%compiler%-%bit%
mkdir %build%

if %compiler%==mingw (
  set "PATH=C:\msys64\mingw%bit%\bin;%PATH%"
  meson %build% --backend ninja
  ninja -C %build%

) else if %compiler%%bit%==msvc32 (
  call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64_x86
  meson %build% --backend vs2015
  MSBuild %build%\hello.sln /p:Configuration=release /p:Platform=Win32

) else if %compiler%%bit%==msvc64 (
  call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
  meson %build% --backend vs2015
  MSBuild %build%\hello.sln /p:Configuration=release /p:Platform=x64
)

file %build%\hello
%build%\hello
