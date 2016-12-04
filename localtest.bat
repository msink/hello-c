rem script for local testing on windows
@echo off
chcp 65001

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
