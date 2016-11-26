rem script for local testing
@echo off

chcp 65001

for %%t in (msvc,mingw) do (
  for %%p in (x86,x64) do (
    for %%c in (debug,release) do (
      set Compiler=%%t
      set Platform=%%p
      set Configuration=%%c
      set build=build\%Compiler%-%Platform%-%Configuration%
      call appveyor.bat
    )
  )
)
