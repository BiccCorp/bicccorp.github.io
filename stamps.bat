@echo off
setlocal enabledelayedexpansion

rem ============================================================
rem  update_stamps.bat
rem  Skanuje folder "stamps" i generuje "stamps\stamps.json"
rem  z lista wszystkich obrazkow. Odpal ten plik po dodaniu
rem  nowych znaczkow do folderu.
rem
rem  UWAGA: nazwy plikow nie powinny zawierac znaku "!" -
rem  psuje to rozwijanie zmiennych w cmd.
rem ============================================================

set "STAMP_DIR=stamps"
set "JSON_FILE=%STAMP_DIR%\stamps.json"

if not exist "%STAMP_DIR%" (
    echo Folder "%STAMP_DIR%" nie istnieje w tym katalogu!
    echo Uruchom ten plik z tego samego miejsca, gdzie jest folder stamps.
    pause
    exit /b 1
)

set "count=0"

for %%f in ("%STAMP_DIR%\*.png" "%STAMP_DIR%\*.jpg" "%STAMP_DIR%\*.jpeg" "%STAMP_DIR%\*.gif" "%STAMP_DIR%\*.webp" "%STAMP_DIR%\*.bmp" "%STAMP_DIR%\*.svg") do (
    if exist "%%f" (
        set /a count+=1
        set "file[!count!]=%%~nxf"
    )
)

if !count! equ 0 (
    echo Nie znaleziono zadnych obrazkow w folderze "%STAMP_DIR%".
    pause
    exit /b 1
)

(
    echo [
    for /l %%i in (1,1,!count!) do (
        if %%i equ !count! (
            echo   "!file[%%i]!"
        ) else (
            echo   "!file[%%i]!",
        )
    )
    echo ]
) > "%JSON_FILE%"

echo.
echo Zaktualizowano %JSON_FILE% ^(%count% plikow^)
pause