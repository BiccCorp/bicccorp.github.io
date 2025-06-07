@echo off
setlocal enabledelayedexpansion

REM Plik wynikowy
set "output=posts.json"

REM Rozpocznij plik JSON
echo [ > %output%

REM Zmienna kontrolna, żeby dodać przecinki między wpisami
set first=1

REM Pętla po plikach .html, pomijając index.html
for /f "delims=" %%f in ('dir /b /o:n *.html ^| findstr /v /i "index.html"') do (
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

    REM Dodaj linię JSON
    >> %output% echo     {"date": "!date!", "title": "!title!", "filename": "wpisy/%%f"}
)

REM Zamknij tablicę JSON
echo ] >> %output%

echo Aktualizacja posts.json zakończona.
pause
