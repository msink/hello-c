@echo off
setlocal
echo.
echo Compiler: %Compiler%
echo Platform: %Platform%
echo Configuration: %Configuration%
echo.

set "PATH=%PATH%;C:\msys64\usr\bin"
set build=build\%Compiler%-%Platform%-%Configuration%
mkdir %build%

if %Compiler%-%Platform%==mingw-x86 (
  set "PATH=C:\msys64\mingw32\bin;%PATH%"
  meson %build% --backend ninja --buildtype %Configuration%
  ninja -C %build%

) else if %Compiler%-%Platform%==mingw-x64 (
  set "PATH=C:\msys64\mingw64\bin;%PATH%"
  meson %build% --backend ninja --buildtype %Configuration%
  ninja -C %build%

) else if %Compiler%-%Platform%==msvc-x86 (
  call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64_x86
  meson %build% --backend vs2015 --buildtype %Configuration%
  MSBuild %build%\hello.sln /p:Platform=Win32

) else if %Compiler%-%Platform%==msvc-x64 (
  call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
  meson %build% --backend vs2015 --buildtype %Configuration%
  MSBuild %build%\hello.sln
)

if %Configuration%==release (strip %build%\hello.exe)

echo.
file %build%\hello.exe
wc -c %build%\hello.exe
size %build%\hello.exe
echo.
%build%\hello
