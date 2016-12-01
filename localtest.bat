rem script for local testing
@echo off
chcp 65001

for %%b in (ninja,vs2015) do (
  for %%t in (mingw,msvc2015) do (
    for %%p in (x86,x64) do (
      for %%c in (debug,release) do (
        set Backend=%%b
        set Compiler=%%t
        set Platform=%%p
        set Configuration=%%c
        set build=build\%%p-%%t-%%b-%%c
        call appveyor.bat
        if ERRORLEVEL 1 pause
      )
    )
  )
)

echo Done.
