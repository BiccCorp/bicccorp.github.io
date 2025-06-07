@echo off
setlocal enabledelayedexpansion

REM Folder z wpisami
set "posts_folder=wpisy"

REM Plik wynikowy w folderze wpisy
set "output=%posts_folder%\posts.json"

REM Rozpocznij plik JSON
echo [ > %output%

REM Zmienna kontrolna, żeby dodać przecinki między wpisami
set first=1

REM Pętla po plikach .html w folderze wpisy, pomijając index.html
for /f "delims=" %%f in ('dir /b /o:n "%posts_folder%\*.html" ^| findstr /v /i "index.html"') do (
    REM Plik aktualny: %%f
    REM Wyciągamy datę (pierwsze 10 znaków)
    set "fname=%%~nf"
    set "date=!fname:~0,10!"

    REM Reszta nazwy po dacie i myślniku
    set "rest=!fname:~11!"

    REM Zamiana myślników na spacje w tytule
    set "title=!rest:-= !"

    REM Dodaj przecinek jeśli to nie pierwszy wpis
    if !first! equ 1 (
        set first=0
    ) else (
        >> %output% echo ,
    )

    REM Dodaj linię JSON — ścieżka w filename jest względna do głównego folderu
    >> %output% echo     {"date": "!date!", "title": "!title!", "filename": "%posts_folder%/%%f"}
)

REM Zamknij tablicę JSON
echo ] >> %output%

echo Aktualizacja posts.json zakończona.
pause
