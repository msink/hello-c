echo Compiler: %compiler%
echo Bits: %bit%

set "PATH=%PATH%;C:\msys64\usr\bin"
set build=build\%compiler%-%bit%
mkdir %build%

if %compiler%==mingw (
  set "PATH=C:\msys64\mingw%bit%\bin;%PATH%"
  meson %build% --backend ninja
  ninja -C %build%
  file %build%\hello
  %build%\hello

) else if %compiler%==msvc (
  if %bit%==32 (
    call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64_x86
    meson %build% --backend vs2015
    type %build%\hello.sln /p:Configuration=Debug /p:Platform=x64
    MSBuild %build%\hello.sln
  ) else if %bit%==64 (
    call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
    meson %build% --backend vs2015
    type %build%\hello.sln /p:Configuration=Debug /p:Platform=Win32
    MSBuild %build%\hello.sln
  )
  file %build%\hello
  %build%\hello

)
