@echo off
if %backend%-%compiler%-%platform%-%configuration%==--- (echo run localtest.bat! && exit /b)

setlocal
echo.
echo Backend: %backend%
echo Compiler: %compiler%
echo Platform: %platform%
echo Buildtype: %configuration%
echo.

if %compiler%==mingw (
  if not %backend%==ninja (echo [skip] && exit /b)
  if %platform%==x86 (
    set "PATH=C:\msys64\mingw32\bin;%PATH%"
  ) else (
    set "PATH=C:\msys64\mingw64\bin;%PATH%"
  )

) else if %compiler%==msvc2015 (
  call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" %platform%
)

if not exist %build% (
  mkdir %build%
  meson %build% --backend %backend% --buildtype %configuration% || exit /b
)

if %backend%==ninja (
  ninja -C %build% || exit /b
) else if %platform%==x86 (
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
