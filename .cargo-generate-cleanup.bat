@echo off
REM Cleanup script to remove backend directories not needed for chosen backend

set BACKEND={{backend}}

echo Cleaning up unused backend files for: %BACKEND%

if "%BACKEND%"=="actix" (
    echo Removing: src-tauri, server, app, routes, resources, public, bootstrap, composer.json, .env.example, Cargo-tauri.toml
    if exist src-tauri rmdir /s /q src-tauri
    if exist server rmdir /s /q server
    if exist app rmdir /s /q app
    if exist routes rmdir /s /q routes
    if exist resources rmdir /s /q resources
    if exist public rmdir /s /q public
    if exist bootstrap rmdir /s /q bootstrap
    if exist composer.json del /q composer.json
    if exist .env.example del /q .env.example
    if exist Cargo-tauri.toml del /q Cargo-tauri.toml
)

if "%BACKEND%"=="tauri" (
    echo Removing: src-actix, server, app, routes, resources, public, bootstrap, composer.json, .env.example, Cargo-actix.toml
    if exist src-actix rmdir /s /q src-actix
    if exist server rmdir /s /q server
    if exist app rmdir /s /q app
    if exist routes rmdir /s /q routes
    if exist resources rmdir /s /q resources
    if exist public rmdir /s /q public
    if exist bootstrap rmdir /s /q bootstrap
    if exist composer.json del /q composer.json
    if exist .env.example del /q .env.example
    if exist Cargo-actix.toml del /q Cargo-actix.toml
)

if "%BACKEND%"=="vanilla" (
    echo Removing: src-actix, src-tauri, server, app, routes, resources, public, bootstrap, composer.json, .env.example, Cargo-actix.toml, Cargo-tauri.toml
    if exist src-actix rmdir /s /q src-actix
    if exist src-tauri rmdir /s /q src-tauri
    if exist server rmdir /s /q server
    if exist app rmdir /s /q app
    if exist routes rmdir /s /q routes
    if exist resources rmdir /s /q resources
    if exist public rmdir /s /q public
    if exist bootstrap rmdir /s /q bootstrap
    if exist composer.json del /q composer.json
    if exist .env.example del /q .env.example
    if exist Cargo-actix.toml del /q Cargo-actix.toml
    if exist Cargo-tauri.toml del /q Cargo-tauri.toml
)

if "%BACKEND%"=="nodejs" (
    echo Removing: src-actix, src-tauri, app, routes, resources, public, bootstrap, composer.json, .env.example, Cargo-actix.toml, Cargo-tauri.toml
    if exist src-actix rmdir /s /q src-actix
    if exist src-tauri rmdir /s /q src-tauri
    if exist app rmdir /s /q app
    if exist routes rmdir /s /q routes
    if exist resources rmdir /s /q resources
    if exist public rmdir /s /q public
    if exist bootstrap rmdir /s /q bootstrap
    if exist composer.json del /q composer.json
    if exist .env.example del /q .env.example
    if exist Cargo-actix.toml del /q Cargo-actix.toml
    if exist Cargo-tauri.toml del /q Cargo-tauri.toml
)

if "%BACKEND%"=="php" (
    echo Removing: src-actix, src-tauri, server, Cargo-actix.toml, Cargo-tauri.toml
    if exist src-actix rmdir /s /q src-actix
    if exist src-tauri rmdir /s /q src-tauri
    if exist server rmdir /s /q server
    if exist Cargo-actix.toml del /q Cargo-actix.toml
    if exist Cargo-tauri.toml del /q Cargo-tauri.toml
)

echo Cleanup complete!
