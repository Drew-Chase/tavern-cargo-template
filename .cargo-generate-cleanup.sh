#!/bin/bash
# Cleanup script to remove backend directories not needed for chosen backend

BACKEND="{{backend}}"

echo "Cleaning up unused backend files for: $BACKEND"

case "$BACKEND" in
  "actix")
    echo "Removing: src-tauri, server, app, routes, resources, public, bootstrap, composer.json, .env.example, Cargo-tauri.toml"
    rm -rf src-tauri server app routes resources public bootstrap composer.json .env.example Cargo-tauri.toml
    ;;
  "tauri")
    echo "Removing: src-actix, server, app, routes, resources, public, bootstrap, composer.json, .env.example, Cargo-actix.toml"
    rm -rf src-actix server app routes resources public bootstrap composer.json .env.example Cargo-actix.toml
    ;;
  "vanilla")
    echo "Removing: src-actix, src-tauri, server, app, routes, resources, public, bootstrap, composer.json, .env.example, Cargo-actix.toml, Cargo-tauri.toml"
    rm -rf src-actix src-tauri server app routes resources public bootstrap composer.json .env.example Cargo-actix.toml Cargo-tauri.toml
    ;;
  "nodejs")
    echo "Removing: src-actix, src-tauri, app, routes, resources, public, bootstrap, composer.json, .env.example, Cargo-actix.toml, Cargo-tauri.toml"
    rm -rf src-actix src-tauri app routes resources public bootstrap composer.json .env.example Cargo-actix.toml Cargo-tauri.toml
    ;;
  "php")
    echo "Removing: src-actix, src-tauri, server, Cargo-actix.toml, Cargo-tauri.toml"
    rm -rf src-actix src-tauri server Cargo-actix.toml Cargo-tauri.toml
    ;;
esac

echo "Cleanup complete!"
