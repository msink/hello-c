rem script for local testing

for %%t in (mingw,msvc) do (
  for %%p in (x86,x64) do (
    for %%c in (debug,release) do (
      setlocal
      set Compiler=%%t
      set Platform=%%p
      set Configuration=%%c
      call appveyor.bat
      endlocal
    )
  )
)
