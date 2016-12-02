@echo off
setlocal
if %compiler%-%platform%-%configuration%==-- (
  echo run localtest.bat! && exit /b
)
echo.
echo Compiler: %compiler%
echo Buildtype: %configuration%
echo Platform: %platform%
echo.

if %compiler%==mingw (
  set "PATH=C:\msys64\mingw%platform%\bin;%PATH%"
) else if %platform%==32 (
  call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64_x86
) else (
  call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64
)

if not exist %build% (
  mkdir %build%
  if "%compiler:-msbuild=%"=="%compiler%" (
    meson %build% --buildtype %configuration% || exit /b
  ) else (
    meson %build% --buildtype %configuration% --backend vs2015 || exit /b
  )
)

if "%compiler:-msbuild=%"=="%compiler%" (
  ninja -C %build% || exit /b
) else if %platform%==X86 (
  MSBuild %build%\hello.sln /verbosity:minimal /p:Platform=Win32 || exit /b
) else (
  MSBuild %build%\hello.sln /verbosity:minimal || exit /b
)

if %compiler%-%configuration%==mingw-release (
  C:\msys64\usr\bin\strip %build%\hello.exe
)

echo.
C:\msys64\usr\bin\file  %build%\hello.exe
C:\msys64\usr\bin\wc -c %build%\hello.exe
C:\msys64\usr\bin\size  %build%\hello.exe
echo.

%build%\hello
