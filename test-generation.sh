#!/bin/bash

# Test script to generate all template variants without user input

echo "=========================================="
echo "Testing TAVERN Template Generation"
echo "=========================================="
echo ""

# Clean up any existing test projects
echo "Cleaning up previous test projects..."
rm -rf test-output
mkdir -p test-output
cd test-output

# Test 1: Actix
echo ""
echo "1/5: Generating Actix template..."
cargo generate --git .. --name test-actix \
  -d backend=actix \
  -d project_description="Test actix project" \
  -d author="Test Author" \
  -d repository="https://github.com/test/test" \
  -d api_port=1421 \
  --silent

# Test 2: Tauri
echo ""
echo "2/5: Generating Tauri template..."
cargo generate --git .. --name test-tauri \
  -d backend=tauri \
  -d project_description="Test tauri project" \
  -d author="Test Author" \
  -d repository="https://github.com/test/test" \
  -d app_identifier="com.test.app" \
  -d window_title="Test App" \
  -d window_width=800 \
  -d window_height=600 \
  -d package_manager=npm \
  --silent

# Test 3: Vanilla
echo ""
echo "3/5: Generating Vanilla template..."
cargo generate --git .. --name test-vanilla \
  -d backend=vanilla \
  -d project_description="Test vanilla project" \
  -d author="Test Author" \
  -d repository="https://github.com/test/test" \
  --silent

# Test 4: Node.js
echo ""
echo "4/5: Generating Node.js template..."
cargo generate --git .. --name test-nodejs \
  -d backend=nodejs \
  -d project_description="Test nodejs project" \
  -d author="Test Author" \
  -d repository="https://github.com/test/test" \
  -d api_port=3001 \
  --silent

# Test 5: PHP
echo ""
echo "5/5: Generating PHP template..."
cargo generate --git .. --name test-php \
  -d backend=php \
  -d project_description="Test php project" \
  -d author="Test Author" \
  -d repository="https://github.com/test/test" \
  -d api_port=8000 \
  --silent

echo ""
echo "=========================================="
echo "Generation Complete! Checking results..."
echo "=========================================="
echo ""

# Function to check directories and show what exists
check_project() {
    local name=$1
    local expected_backend=$2

    echo "📁 $name (Backend: $expected_backend)"
    echo "   Structure:"

    # Check for common directories
    [ -d "$name/src" ] && echo "   ✅ src/" || echo "   ❌ src/"
    [ -d "$name/src-actix" ] && echo "   ⚠️  src-actix/ (should only be in actix)" || echo "   ✅ src-actix/ (removed)"
    [ -d "$name/src-tauri" ] && echo "   ⚠️  src-tauri/ (should only be in tauri)" || echo "   ✅ src-tauri/ (removed)"
    [ -d "$name/server" ] && echo "   ⚠️  server/ (should only be in nodejs)" || echo "   ✅ server/ (removed)"
    [ -d "$name/app" ] && echo "   ⚠️  app/ (should only be in php)" || echo "   ✅ app/ (removed)"
    [ -d "$name/routes" ] && echo "   ⚠️  routes/ (should only be in php)" || echo "   ✅ routes/ (removed)"
    [ -f "$name/Cargo.toml" ] && echo "   ✅ Cargo.toml" || echo "   ❌ Cargo.toml (only needed for actix/tauri)"
    [ -f "$name/composer.json" ] && echo "   ⚠️  composer.json (should only be in php)" || echo "   ✅ composer.json (removed)"

    echo ""
}

# Check each generated project
check_project "test-actix" "actix"
check_project "test-tauri" "tauri"
check_project "test-vanilla" "vanilla"
check_project "test-nodejs" "nodejs"
check_project "test-php" "php"

echo "=========================================="
echo "Detailed Backend-Specific Checks"
echo "=========================================="
echo ""

# Actix specific checks
echo "🔍 Actix Project:"
[ -d "test-actix/src-actix" ] && echo "   ✅ Has src-actix/" || echo "   ❌ Missing src-actix/"
[ ! -d "test-actix/src-tauri" ] && echo "   ✅ No src-tauri/" || echo "   ❌ Has unwanted src-tauri/"
[ ! -d "test-actix/server" ] && echo "   ✅ No server/" || echo "   ❌ Has unwanted server/"
[ ! -d "test-actix/app" ] && echo "   ✅ No app/" || echo "   ❌ Has unwanted app/"
echo ""

# Tauri specific checks
echo "🔍 Tauri Project:"
[ -d "test-tauri/src-tauri" ] && echo "   ✅ Has src-tauri/" || echo "   ❌ Missing src-tauri/"
[ ! -d "test-tauri/src-actix" ] && echo "   ✅ No src-actix/" || echo "   ❌ Has unwanted src-actix/"
[ ! -d "test-tauri/server" ] && echo "   ✅ No server/" || echo "   ❌ Has unwanted server/"
[ ! -d "test-tauri/app" ] && echo "   ✅ No app/" || echo "   ❌ Has unwanted app/"
echo ""

# Vanilla specific checks
echo "🔍 Vanilla Project:"
[ ! -d "test-vanilla/src-actix" ] && echo "   ✅ No src-actix/" || echo "   ❌ Has unwanted src-actix/"
[ ! -d "test-vanilla/src-tauri" ] && echo "   ✅ No src-tauri/" || echo "   ❌ Has unwanted src-tauri/"
[ ! -d "test-vanilla/server" ] && echo "   ✅ No server/" || echo "   ❌ Has unwanted server/"
[ ! -d "test-vanilla/app" ] && echo "   ✅ No app/" || echo "   ❌ Has unwanted app/"
[ ! -f "test-vanilla/Cargo.toml" ] && echo "   ✅ No Cargo.toml" || echo "   ❌ Has unwanted Cargo.toml"
echo ""

# Node.js specific checks
echo "🔍 Node.js Project:"
[ -d "test-nodejs/server" ] && echo "   ✅ Has server/" || echo "   ❌ Missing server/"
[ ! -d "test-nodejs/src-actix" ] && echo "   ✅ No src-actix/" || echo "   ❌ Has unwanted src-actix/"
[ ! -d "test-nodejs/src-tauri" ] && echo "   ✅ No src-tauri/" || echo "   ❌ Has unwanted src-tauri/"
[ ! -d "test-nodejs/app" ] && echo "   ✅ No app/" || echo "   ❌ Has unwanted app/"
[ ! -f "test-nodejs/Cargo.toml" ] && echo "   ✅ No Cargo.toml" || echo "   ❌ Has unwanted Cargo.toml"
echo ""

# PHP specific checks
echo "🔍 PHP Project:"
[ -d "test-php/app" ] && echo "   ✅ Has app/" || echo "   ❌ Missing app/"
[ -d "test-php/routes" ] && echo "   ✅ Has routes/" || echo "   ❌ Missing routes/"
[ -f "test-php/composer.json" ] && echo "   ✅ Has composer.json" || echo "   ❌ Missing composer.json"
[ ! -d "test-php/src-actix" ] && echo "   ✅ No src-actix/" || echo "   ❌ Has unwanted src-actix/"
[ ! -d "test-php/src-tauri" ] && echo "   ✅ No src-tauri/" || echo "   ❌ Has unwanted src-tauri/"
[ ! -d "test-php/server" ] && echo "   ✅ No server/" || echo "   ❌ Has unwanted server/"
echo ""

echo "=========================================="
echo "Test Complete!"
echo "=========================================="
echo ""
echo "Generated projects are in: test-output/"
echo "Inspect them manually to verify everything looks correct."
echo ""
