rem script for local testing
@echo off
chcp 65001

for %%t in (mingw,msvc2015,msvc2015-msbuild) do (
  for %%c in (debug,release) do (
    for %%p in (32,64) do (
      set compiler=%%t
      set configuration=%%c
      set platform=%%p
      set build=build\%%t-%%c-%%p
      call appveyor.bat
      if ERRORLEVEL 1 pause
    )
  )
)

echo Done.
