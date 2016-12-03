rem script for local testing on windows
@echo off
chcp 65001

set "PATH=%PATH:C:\cygwin64\bin;=%"
set "PATH=%PATH:C:\msys64\usr\bin;=%"
set "PATH=%PATH:C:\msys64\mingw64\bin;=%"
set "PATH=%PATH:C:\msys64\mingw32\bin;=%"

for %%t in (^
windows-mingw,^
windows-msvc2015,^
windows-msvc2015-msbuild,^
linux-gcc,^
linux-arm-gcc) do (
  for %%p in (32,64) do (
    for %%c in (debug,release) do (
      set compiler=%%t
      set platform=%%p
      set configuration=%%c
      set build=build\%%t-%%p-%%c
      call appveyor.bat
      if ERRORLEVEL 1 pause
    )
  )
)

echo Done.
