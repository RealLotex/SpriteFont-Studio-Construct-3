@echo off
setlocal
set "SPRITEFONT_HTML=%~dp0SpriteFont-Studio.html"
powershell.exe -NoLogo -NoProfile -NonInteractive -Command - < "%~dp0Servidor-local.ps1"
if errorlevel 1 pause
