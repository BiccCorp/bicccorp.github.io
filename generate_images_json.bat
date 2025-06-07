@echo off
setlocal enabledelayedexpansion

set "folder=galeria"
set "output=%folder%\images.json"

echo [ > "%output%"

set first=1
for %%f in (%folder%\*.jpg %folder%\*.png) do (
    rem Pobieramy datę modyfikacji pliku w formacie RRRR-MM-DD
    for /f %%a in ('powershell -Command "(Get-Item '%%f').LastWriteTime.ToString('yyyy-MM-dd')"') do (
        set "filedate=%%a"
    )
    if !first! equ 1 (
        set first=0
    ) else (
        >> "%output%" echo ,
    )
    >> "%output%" echo {
    >> "%output%" echo     "filename": "%%~nxf",
    >> "%output%" echo     "date": "!filedate!"
    >> "%output%" echo }
)

echo ] >> "%output%"

echo Gotowe! Plik "%output%" został wygenerowany.
pause
