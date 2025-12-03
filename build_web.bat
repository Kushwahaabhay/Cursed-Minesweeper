@echo off
echo ========================================
echo   CURSED MINESWEEPER - WEB BUILD
echo ========================================
echo.

echo Cleaning previous build...
call flutter clean
echo.

echo Getting dependencies...
call flutter pub get
echo.

echo Building for web (release mode)...
call flutter build web --release --web-renderer auto
echo.

if %ERRORLEVEL% EQU 0 (
    echo ========================================
    echo   BUILD SUCCESSFUL!
    echo ========================================
    echo.
    echo Output directory: build\web\
    echo.
    echo To test locally, run:
    echo   cd build\web
    echo   python -m http.server 8000
    echo.
    echo Then open: http://localhost:8000
    echo.
    echo ========================================
    echo   DEPLOYMENT OPTIONS
    echo ========================================
    echo.
    echo 1. NETLIFY (Easiest):
    echo    - Go to https://app.netlify.com/drop
    echo    - Drag the build\web folder
    echo.
    echo 2. GITHUB PAGES:
    echo    git subtree push --prefix build/web origin gh-pages
    echo.
    echo 3. VERCEL:
    echo    cd build\web
    echo    vercel --prod
    echo.
    echo 4. FIREBASE:
    echo    firebase deploy
    echo.
) else (
    echo ========================================
    echo   BUILD FAILED!
    echo ========================================
    echo.
    echo Please check the error messages above.
    echo.
)

pause
