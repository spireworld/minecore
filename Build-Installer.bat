@echo off
chcp 65001 > nul
echo ==========================================
echo   Збірка MineCore Installer.exe
echo ==========================================
powershell -ExecutionPolicy Bypass -File "%~dp0build.ps1"
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ПОМИЛКА] Переконайтесь, що встановлено .NET 10 SDK: https://dotnet.microsoft.com/download
    pause
    exit /b 1
)
echo.
echo Готово! Інсталятор знаходиться у папці: artifacts\Installer.exe
explorer "%~dp0artifacts"
pause
