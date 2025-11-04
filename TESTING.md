# TAVERN Template Testing Guide

This guide explains how to test the TAVERN cargo-generate template to ensure all variants generate correctly.

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Automated Testing](#automated-testing)
- [Manual Testing](#manual-testing)
- [Testing Individual Variants](#testing-individual-variants)
- [Validation Checklist](#validation-checklist)
- [CI/CD Testing](#cicd-testing)

## Overview

The TAVERN template supports 5 backend variants:
1. **Actix** - Rust web server
2. **Tauri** - Desktop application
3. **Vanilla** - Frontend only
4. **Node.js** - Express server
5. **PHP** - Laravel framework

Each variant must be tested to ensure:
- Correct files are included/excluded
- Dependencies install successfully
- Projects build without errors
- Development servers start correctly
- Production builds work

## Prerequisites

### Required Tools
```bash
# Rust and cargo-generate
cargo install cargo-generate

# Node.js (v18+)
# Download from https://nodejs.org/

# Git
# Download from https://git-scm.com/
```

### Optional (for full testing)
```bash
# PHP 8.2+ (for PHP variant)
# Download from https://www.php.net/

# Composer (for PHP variant)
# Download from https://getcomposer.org/

# Platform-specific tools for Tauri
# See README.md for Tauri prerequisites
```

## Automated Testing

The template includes automated test scripts that generate all variants and validate the output.

### Running Tests (Unix/Mac/Linux)

```bash
# Make script executable (first time only)
chmod +x test-generation.sh

# Run all tests
./test-generation.sh
```

### Running Tests (Windows)

```cmd
# Run all tests
test-generation.bat
```

### What the Test Script Does

1. **Cleans previous test output**
   - Removes `test-output/` directory
   - Creates fresh output directory

2. **Generates all 5 variants**
   - Creates test projects with default values
   - Uses silent mode (no prompts)
   - Generates into `test-output/` directory

3. **Validates structure**
   - Checks for required directories
   - Verifies unwanted directories are removed
   - Confirms backend-specific files exist
   - Reports discrepancies

4. **Displays results**
   - Shows pass/fail for each check
   - Lists generated projects
   - Highlights any issues

### Reading Test Output

#### Success Indicators
```
✅ src/                     # Directory exists (should exist)
✅ No src-actix/           # Directory doesn't exist (should be removed)
```

#### Warning/Error Indicators
```
⚠️  src-actix/ (should only be in actix)  # Directory exists but shouldn't
❌ Missing src-tauri/                      # Required directory missing
```

### Test Output Structure

After running tests:
```
test-output/
├── test-actix/       # Actix variant
├── test-tauri/       # Tauri variant
├── test-vanilla/     # Vanilla variant
├── test-nodejs/      # Node.js variant
└── test-php/         # PHP variant
```

## Manual Testing

### 1. Generate a Single Variant

```bash
# From template directory
cargo generate --git . --name my-test-project
```

Follow the prompts and provide test values.

### 2. Generate with Pre-defined Values

```bash
# Actix example
cargo generate --git . --name test-actix \
  -d backend=actix \
  -d project_description="Test project" \
  -d author="testuser" \
  -d repository="https://github.com/test/test" \
  -d api_port=1421

# Tauri example
cargo generate --git . --name test-tauri \
  -d backend=tauri \
  -d project_description="Test project" \
  -d author="testuser" \
  -d repository="https://github.com/test/test" \
  -d app_identifier="com.test.app" \
  -d window_title="Test App" \
  -d window_width=800 \
  -d window_height=600 \
  -d package_manager=npm

# Vanilla example
cargo generate --git . --name test-vanilla \
  -d backend=vanilla \
  -d project_description="Test project" \
  -d author="testuser" \
  -d repository="https://github.com/test/test"

# Node.js example
cargo generate --git . --name test-nodejs \
  -d backend=nodejs \
  -d project_description="Test project" \
  -d author="testuser" \
  -d repository="https://github.com/test/test" \
  -d api_port=3001

# PHP example
cargo generate --git . --name test-php \
  -d backend=php \
  -d project_description="Test project" \
  -d author="testuser" \
  -d repository="https://github.com/test/test" \
  -d api_port=8000
```

### 3. Test from GitHub

Test the published template:

```bash
cargo generate --git https://github.com/Drew-Chase/tavern-cargo-template --name test-project
```

## Testing Individual Variants

### Actix Variant

**1. Generate:**
```bash
cargo generate --git . --name test-actix -d backend=actix -d api_port=1421
cd test-actix
```

**2. Verify structure:**
```bash
# Should exist
ls src/              # Frontend
ls src-actix/        # Backend
ls Cargo.toml        # Rust config

# Should NOT exist
ls src-tauri/        # Should fail (removed)
ls server/           # Should fail (removed)
ls app/              # Should fail (removed)
ls composer.json     # Should fail (removed)
```

**3. Install dependencies:**
```bash
npm install
```

**4. Build frontend:**
```bash
npm run build-frontend
```

**5. Build backend:**
```bash
cargo build --release
```

**6. Run development:**
```bash
# Terminal 1
npm run watch

# Terminal 2
npm run dev
```

**7. Test production:**
```bash
npm run build
cargo run --release
# Visit http://localhost:1421
```

### Tauri Variant

**1. Generate:**
```bash
cargo generate --git . --name test-tauri -d backend=tauri \
  -d app_identifier="com.test.app" \
  -d window_title="Test" \
  -d window_width=800 \
  -d window_height=600 \
  -d package_manager=npm
cd test-tauri
```

**2. Verify structure:**
```bash
# Should exist
ls src/              # Frontend
ls src-tauri/        # Tauri backend
ls Cargo.toml        # Rust config

# Should NOT exist
ls src-actix/        # Should fail
ls server/           # Should fail
ls app/              # Should fail
```

**3. Install dependencies:**
```bash
npm install
```

**4. Run development:**
```bash
npm run tauri-dev
```

**5. Build production:**
```bash
npm run tauri-build
# Check src-tauri/target/release/bundle/
```

### Vanilla Variant

**1. Generate:**
```bash
cargo generate --git . --name test-vanilla -d backend=vanilla
cd test-vanilla
```

**2. Verify structure:**
```bash
# Should exist
ls src/              # Frontend
ls package.json      # Node config
ls vite.config.ts    # Vite config

# Should NOT exist
ls src-actix/        # Should fail
ls src-tauri/        # Should fail
ls server/           # Should fail
ls app/              # Should fail
ls Cargo.toml        # Should fail
ls composer.json     # Should fail
```

**3. Install dependencies:**
```bash
npm install
```

**4. Run development:**
```bash
npm run dev
# Visit http://localhost:5173
```

**5. Build production:**
```bash
npm run build
npm run preview
```

### Node.js Variant

**1. Generate:**
```bash
cargo generate --git . --name test-nodejs -d backend=nodejs -d api_port=3001
cd test-nodejs
```

**2. Verify structure:**
```bash
# Should exist
ls src/              # Frontend
ls server/           # Express backend
ls package.json      # Node config

# Should NOT exist
ls src-actix/        # Should fail
ls src-tauri/        # Should fail
ls app/              # Should fail
ls Cargo.toml        # Should fail
ls composer.json     # Should fail
```

**3. Install dependencies:**
```bash
npm install
```

**4. Run development (concurrent):**
```bash
npm run dev
# Frontend: http://localhost:5173
# Backend: http://localhost:3001
```

**5. Build and run production:**
```bash
npm run build
npm start
# Visit http://localhost:3001
```

### PHP Variant

**1. Generate:**
```bash
cargo generate --git . --name test-php -d backend=php -d api_port=8000
cd test-php
```

**2. Verify structure:**
```bash
# Should exist
ls src/              # Frontend
ls app/              # Laravel app
ls routes/           # Laravel routes
ls resources/        # Laravel resources
ls public/           # Laravel public
ls composer.json     # PHP dependencies
ls .env.example      # Environment template

# Should NOT exist
ls src-actix/        # Should fail
ls src-tauri/        # Should fail
ls server/           # Should fail
ls Cargo.toml        # Should fail
```

**3. Fix PHP configuration (if needed):**
```bash
# Enable OpenSSL extension
# Edit php.ini and uncomment:
# extension=openssl
# extension_dir = "/path/to/php/ext"
```

**4. Install dependencies:**
```bash
composer install
npm install
```

**5. Setup Laravel:**
```bash
cp .env.example .env
php artisan key:generate
```

**6. Run development:**
```bash
# Terminal 1
php artisan serve

# Terminal 2
npm run dev
# Visit http://localhost:8000
```

**7. Build production:**
```bash
npm run build
# Assets in public/build/
```

## Validation Checklist

Use this checklist for each variant:

### File Structure
- [ ] `src/` directory exists
- [ ] Only appropriate backend directory exists
- [ ] No unwanted backend directories remain
- [ ] Configuration files have correct content
- [ ] No Liquid template syntax remains in files
- [ ] `.env.example` only in PHP variant
- [ ] `Cargo.toml` only in Actix/Tauri variants
- [ ] `composer.json` only in PHP variant

### Dependencies
- [ ] `npm install` succeeds
- [ ] `cargo build` succeeds (Rust variants)
- [ ] `composer install` succeeds (PHP variant)
- [ ] No missing dependency errors
- [ ] Lock files generate correctly

### Development Mode
- [ ] Frontend dev server starts (`npm run dev`)
- [ ] Backend server starts (if applicable)
- [ ] Hot reload works for frontend
- [ ] Hot reload works for backend (if applicable)
- [ ] API endpoints respond correctly
- [ ] No console errors in browser
- [ ] Theme switching works
- [ ] Navigation works

### Production Build
- [ ] `npm run build` succeeds
- [ ] Backend builds successfully (if applicable)
- [ ] Production server starts
- [ ] All assets load correctly
- [ ] No 404 errors for assets
- [ ] Application functions correctly
- [ ] Build output size is reasonable

### Code Quality
- [ ] No TypeScript errors
- [ ] ESLint runs without errors
- [ ] No Rust warnings (if applicable)
- [ ] No PHP errors (if applicable)
- [ ] Code formatting is consistent

## CI/CD Testing

### GitHub Actions Example

Create `.github/workflows/test-template.yml`:

```yaml
name: Test Template Generation

on:
  push:
    branches: [ master, main, develop ]
  pull_request:
    branches: [ master, main ]

jobs:
  test-generation:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        backend: [actix, tauri, vanilla, nodejs, php]

    steps:
    - uses: actions/checkout@v3

    - name: Install Rust
      uses: actions-rs/toolchain@v1
      with:
        toolchain: stable
        profile: minimal

    - name: Install cargo-generate
      run: cargo install cargo-generate

    - name: Install Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'

    - name: Install PHP (for PHP variant)
      if: matrix.backend == 'php'
      uses: shivammathur/setup-php@v2
      with:
        php-version: '8.2'
        extensions: openssl, mbstring

    - name: Install Composer (for PHP variant)
      if: matrix.backend == 'php'
      run: |
        php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
        php composer-setup.php
        php -r "unlink('composer-setup.php');"
        sudo mv composer.phar /usr/local/bin/composer

    - name: Generate template
      run: |
        cargo generate --git . --name test-${{ matrix.backend }} \
          -d backend=${{ matrix.backend }} \
          -d project_description="Test project" \
          -d author="ci-test" \
          -d repository="https://github.com/test/test" \
          -d api_port=3000

    - name: Install Node dependencies
      working-directory: test-${{ matrix.backend }}
      run: npm install

    - name: Install Composer dependencies
      if: matrix.backend == 'php'
      working-directory: test-${{ matrix.backend }}
      run: composer install --no-interaction

    - name: Build frontend
      working-directory: test-${{ matrix.backend }}
      run: npm run build

    - name: Build Rust backend
      if: matrix.backend == 'actix' || matrix.backend == 'tauri'
      working-directory: test-${{ matrix.backend }}
      run: cargo build --release
```

## Troubleshooting

### Template Generation Fails
```bash
# Use verbose mode for details
cargo generate --git . --name test --verbose

# Check cargo-generate version
cargo generate --version  # Should be >= 0.10.0
```

### Dependencies Won't Install

**Node.js:**
```bash
# Clear cache
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

**Rust:**
```bash
# Update Rust
rustup update
cargo clean
cargo build
```

**PHP:**
```bash
# Check PHP configuration
php -m  # List loaded extensions
php -i  # Full PHP info

# Clear Composer cache
composer clear-cache
rm -rf vendor composer.lock
composer install
```

### Build Errors

**TypeScript errors:**
```bash
# Check tsconfig.json is correct
npx tsc --noEmit

# Rebuild
npm run build
```

**Rust errors:**
```bash
# Check Cargo.toml is correct
cargo check

# Clean and rebuild
cargo clean
cargo build
```

### Generated Files Contain Liquid Syntax

This indicates the template syntax wasn't processed:
- Check cargo-generate version (must be >= 0.10.0)
- Verify file has correct extension (.rs, .json, .toml, etc.)
- Check cargo-generate.toml for file exclusions

### Backend Directories Not Removed

Check `.cargo-generate-cleanup.rhai`:
- Verify conditional logic is correct
- Ensure file paths match actual structure
- Test with `--verbose` to see cleanup output

## Best Practices

1. **Test all variants** after any template changes
2. **Test on multiple platforms** (Windows, Mac, Linux)
3. **Verify both development and production** builds
4. **Check for console errors** in browser and terminal
5. **Test dependency installation** from clean state
6. **Validate generated code quality** (no errors/warnings)
7. **Test from GitHub** to verify published template works
8. **Document any known issues** for specific platforms

## Resources

- [DEVELOPMENT.md](DEVELOPMENT.md) - Template development guide
- [PACKAGING.md](PACKAGING.md) - Publishing guide
- [cargo-generate docs](https://cargo-generate.github.io/cargo-generate/)
- [Main README.md](README.md) - User documentation

---

**Happy testing!**
