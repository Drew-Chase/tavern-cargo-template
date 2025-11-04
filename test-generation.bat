@echo off
setlocal enabledelayedexpansion

REM Test script to generate all template variants without user input

echo ==========================================
echo Testing TAVERN Template Generation
echo ==========================================
echo.

REM Clean up any existing test projects
echo Cleaning up previous test projects...
if exist test-output rmdir /s /q test-output
mkdir test-output
cd test-output

REM Test 1: Actix
echo.
echo 1/5: Generating Actix template...
cargo generate --git .. --name test-actix -d backend=actix -d project_description="Test actix project" -d author="Test Author" -d repository="https://github.com/test/test" -d api_port=1421 --silent

REM Test 2: Tauri
echo.
echo 2/5: Generating Tauri template...
cargo generate --git .. --name test-tauri -d backend=tauri -d project_description="Test tauri project" -d author="Test Author" -d repository="https://github.com/test/test" -d app_identifier="com.test.app" -d window_title="Test App" -d window_width=800 -d window_height=600 -d package_manager=npm --silent

REM Test 3: Vanilla
echo.
echo 3/5: Generating Vanilla template...
cargo generate --git .. --name test-vanilla -d backend=vanilla -d project_description="Test vanilla project" -d author="Test Author" -d repository="https://github.com/test/test" --silent

REM Test 4: Node.js
echo.
echo 4/5: Generating Node.js template...
cargo generate --git .. --name test-nodejs -d backend=nodejs -d project_description="Test nodejs project" -d author="Test Author" -d repository="https://github.com/test/test" -d api_port=3001 --silent

REM Test 5: PHP
echo.
echo 5/5: Generating PHP template...
cargo generate --git .. --name test-php -d backend=php -d project_description="Test php project" -d author="Test Author" -d repository="https://github.com/test/test" -d api_port=8000 --silent

echo.
echo ==========================================
echo Generation Complete! Checking results...
echo ==========================================
echo.

REM Check each generated project
echo [Actix Project]
if exist test-actix\src echo    [OK] src/
if exist test-actix\src-actix (echo    [OK] src-actix/) else (echo    [FAIL] Missing src-actix/)
if exist test-actix\src-tauri (echo    [FAIL] Has unwanted src-tauri/) else (echo    [OK] No src-tauri/)
if exist test-actix\server (echo    [FAIL] Has unwanted server/) else (echo    [OK] No server/)
if exist test-actix\app (echo    [FAIL] Has unwanted app/) else (echo    [OK] No app/)
echo.

echo [Tauri Project]
if exist test-tauri\src echo    [OK] src/
if exist test-tauri\src-tauri (echo    [OK] src-tauri/) else (echo    [FAIL] Missing src-tauri/)
if exist test-tauri\src-actix (echo    [FAIL] Has unwanted src-actix/) else (echo    [OK] No src-actix/)
if exist test-tauri\server (echo    [FAIL] Has unwanted server/) else (echo    [OK] No server/)
if exist test-tauri\app (echo    [FAIL] Has unwanted app/) else (echo    [OK] No app/)
echo.

echo [Vanilla Project]
if exist test-vanilla\src echo    [OK] src/
if exist test-vanilla\src-actix (echo    [FAIL] Has unwanted src-actix/) else (echo    [OK] No src-actix/)
if exist test-vanilla\src-tauri (echo    [FAIL] Has unwanted src-tauri/) else (echo    [OK] No src-tauri/)
if exist test-vanilla\server (echo    [FAIL] Has unwanted server/) else (echo    [OK] No server/)
if exist test-vanilla\app (echo    [FAIL] Has unwanted app/) else (echo    [OK] No app/)
if exist test-vanilla\Cargo.toml (echo    [FAIL] Has unwanted Cargo.toml) else (echo    [OK] No Cargo.toml)
echo.

echo [Node.js Project]
if exist test-nodejs\src echo    [OK] src/
if exist test-nodejs\server (echo    [OK] server/) else (echo    [FAIL] Missing server/)
if exist test-nodejs\src-actix (echo    [FAIL] Has unwanted src-actix/) else (echo    [OK] No src-actix/)
if exist test-nodejs\src-tauri (echo    [FAIL] Has unwanted src-tauri/) else (echo    [OK] No src-tauri/)
if exist test-nodejs\app (echo    [FAIL] Has unwanted app/) else (echo    [OK] No app/)
if exist test-nodejs\Cargo.toml (echo    [FAIL] Has unwanted Cargo.toml) else (echo    [OK] No Cargo.toml)
echo.

echo [PHP Project]
if exist test-php\src echo    [OK] src/
if exist test-php\app (echo    [OK] app/) else (echo    [FAIL] Missing app/)
if exist test-php\routes (echo    [OK] routes/) else (echo    [FAIL] Missing routes/)
if exist test-php\composer.json (echo    [OK] composer.json) else (echo    [FAIL] Missing composer.json)
if exist test-php\src-actix (echo    [FAIL] Has unwanted src-actix/) else (echo    [OK] No src-actix/)
if exist test-php\src-tauri (echo    [FAIL] Has unwanted src-tauri/) else (echo    [OK] No src-tauri/)
if exist test-php\server (echo    [FAIL] Has unwanted server/) else (echo    [OK] No server/)
echo.

echo ==========================================
echo Test Complete!
echo ==========================================
echo.
echo Generated projects are in: test-output\
echo Inspect them manually to verify everything looks correct.
echo.
