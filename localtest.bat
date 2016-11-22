rem script for local testing

for %%c in (mingw,msvc) do (
  for %%b in (32,64) do (
    setlocal
    set compiler=%%c
    set bit=%%b
    call appveyor.bat
    endlocal
  )
)
