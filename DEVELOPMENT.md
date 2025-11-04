# TAVERN Template Development Guide

This guide is for developers who want to contribute to or modify the TAVERN cargo-generate template itself.

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Template Mechanics](#template-mechanics)
- [Development Workflow](#development-workflow)
- [Testing Changes](#testing-changes)
- [Common Tasks](#common-tasks)

## Overview

The TAVERN template is a cargo-generate template that creates full-stack applications with multiple backend options. It uses conditional file inclusion to generate only the files needed for the chosen backend.

### Key Technologies
- **cargo-generate**: Template generation engine
- **Liquid templating**: For conditional content in files (Rust, JSON, etc.)
- **Rhai scripting**: For post-generation cleanup
- **cargo-generate.toml**: Template configuration and placeholders

## Prerequisites

To work on this template, you need:

1. **Rust and Cargo** (latest stable)
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

2. **cargo-generate**
   ```bash
   cargo install cargo-generate
   ```

3. **Node.js** (v18+) - for testing frontend builds
   ```bash
   # Download from https://nodejs.org/
   ```

4. **Optional: PHP & Composer** - for testing PHP variant
   ```bash
   # Download PHP from https://www.php.net/
   # Download Composer from https://getcomposer.org/
   ```

5. **Git** - for version control

## Project Structure

```
tavern-cargo-template/
├── .cargo-generate-cleanup.rhai    # Post-generation cleanup script
├── .cargo-generate-cleanup.sh      # Manual cleanup (reference)
├── .cargo-generate-cleanup.bat     # Manual cleanup (Windows)
├── .genignore                      # Files excluded from generation
├── cargo-generate.toml             # Template configuration
├── Cargo.toml                      # Template for Rust variants
├── Cargo-actix.toml               # Actix-specific Cargo config
├── Cargo-tauri.toml               # Tauri-specific Cargo config
├── composer.json                   # Template for PHP variant
├── package.json                    # Template for all variants
├── test-generation.sh              # Test script (Unix/Mac)
├── test-generation.bat             # Test script (Windows)
│
├── src/                           # React frontend (shared)
│   ├── assets/
│   │   ├── components/           # UI components
│   │   ├── css/                  # Styles and fonts
│   │   ├── pages/                # Page components
│   │   └── providers/            # React context providers
│   └── main.tsx                  # Frontend entry point
│
├── src-actix/                    # Actix backend (conditional)
│   ├── main.rs
│   └── test_endpoint.rs
│
├── src-tauri/                    # Tauri backend (conditional)
│   ├── src/
│   ├── Cargo.toml
│   └── tauri.conf.json
│
├── server/                       # Node.js backend (conditional)
│   └── index.js
│
├── app/                          # Laravel backend (conditional)
├── routes/                       # Laravel routes (conditional)
├── resources/                    # Laravel views (conditional)
├── public/                       # Laravel public (conditional)
└── bootstrap/                    # Laravel bootstrap (conditional)
```

### Important Files

#### `.genignore`
Lists files that should NOT be copied during generation:
- Test scripts (`test-generation.sh`, `test-generation.bat`)
- Test output directory
- Cleanup scripts (except .rhai)
- Development files

#### `cargo-generate.toml`
Defines:
- Template metadata
- Placeholders (variables users provide)
- Conditional placeholders (backend-specific)
- File exclusions
- Post-generation hooks

#### `.cargo-generate-cleanup.rhai`
Post-generation script that:
1. Removes backend directories not chosen
2. Renames appropriate Cargo.toml variant
3. Cleans up unused configuration files

## Template Mechanics

### Liquid Templating

Files use Liquid syntax for conditional content:

**Example from `Cargo.toml`:**
```liquid
{% if backend == "actix" -%}
[package]
name = "{{crate_name}}"
# ... actix config
{%- elsif backend == "tauri" -%}
[package]
name = "{{crate_name}}"
# ... tauri config
{%- endif %}
```

**Example from `package.json`:**
```liquid
"scripts": {
  {% if backend == "actix" -%}
  "dev": "vite",
  "watch": "cargo watch -q -c -w src-actix/ -x run"
  {%- elsif backend == "nodejs" -%}
  "dev": "concurrently \"vite\" \"nodemon server/index.js\""
  {%- endif %}
}
```

### Variables

Available template variables:
- `{{crate_name}}` - Project name (from user)
- `{{project_description}}` - Description (from user)
- `{{authors}}` - Author name (from user)
- `{{author}}` - Author/vendor name (from user, for PHP)
- `{{repository}}` - Repository URL (from user)
- `{{backend}}` - Backend type: actix, tauri, vanilla, nodejs, php
- `{{api_port}}` - API port for actix/nodejs/php
- `{{app_identifier}}` - Tauri app identifier
- `{{window_title}}` - Tauri window title
- `{{window_width}}` - Tauri window width
- `{{window_height}}` - Tauri window height
- `{{package_manager}}` - Package manager for Tauri (npm, yarn, pnpm)

### Conditional File Inclusion

The template uses two mechanisms for conditional inclusion:

1. **cargo-generate exclusions** (in `cargo-generate.toml`):
   ```toml
   [conditional.'backend == "php"']
   exclude = [
       "resources/views/**/*.blade.php",
   ]
   ```

2. **Rhai cleanup script** (runs after generation):
   ```rhai
   if backend == "actix" {
       file::delete("src-tauri");
       file::delete("server");
       file::delete("app");
       // ...
   }
   ```

## Development Workflow

### 1. Clone the Repository
```bash
git clone https://github.com/Drew-Chase/tavern-cargo-template.git
cd tavern-cargo-template
```

### 2. Make Changes

Edit template files following these guidelines:

**For shared frontend files:**
- Edit files in `src/` directory
- These files are included in ALL variants
- No Liquid templating needed

**For backend-specific files:**
- Edit files in backend directories (`src-actix/`, `src-tauri/`, `server/`, `app/`, etc.)
- Add conditional deletion logic to `.cargo-generate-cleanup.rhai`

**For configuration files with conditional content:**
- Use Liquid templating (`{% if backend == "..." %}`)
- Test ALL backend variants after changes
- Keep shared content outside conditionals

### 3. Test Your Changes

**Quick test (single variant):**
```bash
# From template root
cargo generate --git . --name test-project -d backend=actix
```

**Comprehensive test (all variants):**
```bash
# Unix/Mac
./test-generation.sh

# Windows
test-generation.bat
```

See [TESTING.md](TESTING.md) for detailed testing instructions.

### 4. Verify Generated Projects

After generation, check that:
- Only appropriate backend files exist
- No unwanted directories remain
- Configuration files have correct content
- No Liquid syntax remains in generated files
- Dependencies install correctly
- Projects build successfully

## Common Tasks

### Adding a New Backend Variant

1. **Add to backend choices** in `cargo-generate.toml`:
   ```toml
   [placeholders.backend]
   choices = ["actix", "tauri", "vanilla", "nodejs", "php", "your-new-backend"]
   ```

2. **Create backend directory:**
   ```bash
   mkdir your-backend-dir
   # Add your backend files
   ```

3. **Add conditional logic** to configuration files:
   ```liquid
   {%- elsif backend == "your-new-backend" -%}
   # your backend config
   ```

4. **Update cleanup script** (`.cargo-generate-cleanup.rhai`):
   ```rhai
   } else if backend == "your-new-backend" {
       file::delete("src-actix");
       file::delete("src-tauri");
       // ... delete other backends
   }
   ```

5. **Update documentation** (README.md, DEVELOPMENT.md, etc.)

6. **Add test case** to test scripts

### Modifying Shared Frontend

Changes to `src/` directory affect ALL backends:

1. Edit files in `src/`
2. Test with multiple backends:
   ```bash
   cargo generate --git . --name test-actix -d backend=actix
   cargo generate --git . --name test-vanilla -d backend=vanilla
   ```
3. Verify both projects work correctly

### Adding a New Placeholder Variable

1. **Add to `cargo-generate.toml`:**
   ```toml
   [placeholders]
   your_variable = { type = "string", prompt = "Your prompt", default = "default-value" }
   ```

2. **Use in template files:**
   ```liquid
   "name": "{{your_variable}}"
   ```

3. **Add to test scripts** with `-d your_variable=test-value`

### Updating Dependencies

**Node.js dependencies (package.json):**
```json
"dependencies": {
  "react": "18.3.1",  // Update version
  // ...
}
```

**Rust dependencies:**
- Edit appropriate Cargo.toml variant
- Consider compatibility across Rust editions

**PHP dependencies (composer.json):**
```json
"require": {
  "laravel/framework": "^11.0"  // Update version
}
```

After updating, test installation in generated projects.

### Excluding Files from Generation

Add to `.genignore`:
```
your-file.txt
your-directory/
```

Files in `.genignore` won't be copied during project generation.

## Best Practices

1. **Test all backends** after making changes
2. **Keep frontend unified** - avoid backend-specific frontend code
3. **Use Liquid templating** for conditional config content
4. **Document new features** in README.md
5. **Validate template variables** with regex in cargo-generate.toml
6. **Keep cleanup script in sync** with backend directories
7. **Avoid placeholder collisions** - use unique variable names
8. **Test on multiple platforms** (Windows, Mac, Linux)

## Troubleshooting

### Template Won't Generate
- Check cargo-generate.toml syntax
- Verify all placeholders are defined
- Ensure regex patterns are valid

### Files Not Being Excluded
- Check .genignore syntax
- Verify cleanup script logic
- Test with `--verbose` flag

### Liquid Syntax Errors
- Balance all `{% if %}` with `{% endif %}`
- Use `-%}` and `{%-` to control whitespace
- Escape special characters if needed

### Cleanup Script Fails
- Verify Rhai syntax
- Check file paths (case-sensitive)
- Test with `cargo generate --verbose`

## Resources

- [cargo-generate Documentation](https://cargo-generate.github.io/cargo-generate/)
- [Liquid Templating](https://shopify.github.io/liquid/)
- [Rhai Scripting Language](https://rhai.rs/)
- [TESTING.md](TESTING.md) - Template testing guide
- [PACKAGING.md](PACKAGING.md) - Publishing guide

## Getting Help

- Create an issue: https://github.com/Drew-Chase/tavern-cargo-template/issues
- Read the main README.md for user-facing documentation
- Check cargo-generate documentation for template syntax

---

**Happy template development!**
