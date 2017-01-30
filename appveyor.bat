@echo off
setlocal
if %compiler%-%platform%-%configuration%==-- (
  echo run localtest.bat! && exit /b
)
echo.
echo Compiler: %compiler%
echo Platform: %platform% bit
echo Buildtype: %configuration%
echo.

if %compiler:windows-=%==%compiler% (
  set "PATH=C:\cygwin-cross\bin;%PATH%"
) else if %compiler%==windows-mingw (
  set "PATH=C:\msys64\mingw%platform%\bin;%PATH%"
) else if %platform%==32 (
  call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64_x86
) else (
  call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64
)

if not exist %build% (
  mkdir %build%
  if %compiler:windows-=%==%compiler% (
    meson %build% --buildtype %configuration% --cross-file compilers\%compiler%-%platform%.txt || exit /b
  ) else if not %compiler%==%compiler:-msbuild=% (
    meson %build% --buildtype %configuration% --backend vs2015 || exit /b
  ) else (
    meson %build% --buildtype %configuration% || exit /b
  )
)

if %compiler%==%compiler:-msbuild=% (
  ninja -C %build% || exit /b
) else if %platform%==X86 (
  MSBuild %build%\hello.sln /verbosity:minimal /p:Platform=Win32 || exit /b
) else (
  MSBuild %build%\hello.sln /verbosity:minimal || exit /b
)

if %compiler%-%configuration%==windows-mingw-release (
  C:\msys64\usr\bin\strip %build%\hello.exe
)

echo.
if not %compiler%==%compiler:windows-=% (
  C:\msys64\usr\bin\file  %build%\hello.exe
  C:\msys64\usr\bin\wc -c %build%\hello.exe
  C:\msys64\usr\bin\size  %build%\hello.exe
  %build%\hello
) else if not %compiler%==%compiler:osx-=% (
  C:\msys64\usr\bin\file  %build%\hello
  C:\msys64\usr\bin\wc -c %build%\hello
  C:\cygwin-cross\bin\x86_64-apple-darwin14-size %build%\hello
) else (
  C:\msys64\usr\bin\file  %build%\hello
  C:\msys64\usr\bin\wc -c %build%\hello
  C:\msys64\usr\bin\size  %build%\hello
)
echo.
