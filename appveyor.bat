@echo off
setlocal
echo.
echo Compiler: %Compiler%
echo Platform: %Platform%
echo Configuration: %Configuration%
echo.

set "PATH=%PATH%;C:\msys64\usr\bin"

if %Compiler%-%Platform%==mingw-x86 (
  set "PATH=C:\msys64\mingw32\bin;%PATH%"
  if not exist %build% (
    mkdir %build%
    meson %build% --backend ninja --buildtype %Configuration% || exit /b
  )
  ninja -C %build% || exit /b

) else if %Compiler%-%Platform%==mingw-x64 (
  set "PATH=C:\msys64\mingw64\bin;%PATH%"
  if not exist %build% (
    mkdir %build%
    meson %build% --backend ninja --buildtype %Configuration% || exit /b
  )
  ninja -C %build% || exit /b

) else if %Compiler%-%Platform%==msvc2015-x86 (
  call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" x86
  if not exist %build% (
    mkdir %build%
    meson %build% --backend vs2015 --buildtype %Configuration% || exit /b
  )
  MSBuild %build%\hello.sln /verbosity:minimal /p:Platform=Win32 || exit /b

) else if %Compiler%-%Platform%==msvc2015-x64 (
  call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" x86_amd64
  if not exist %build% (
    mkdir %build%
    meson %build% --backend vs2015 --buildtype %Configuration% || exit /b
  )
  MSBuild %build%\hello.sln /verbosity:minimal || exit /b
)

if %Configuration%==release (strip %build%\hello.exe)

echo.
file %build%\hello.exe
wc -c %build%\hello.exe
size %build%\hello.exe
echo.
%build%\hello
