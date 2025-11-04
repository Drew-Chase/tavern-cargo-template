# TAVERN Template Packaging & Publishing Guide

This guide explains how to package, publish, and distribute the TAVERN cargo-generate template.

## Table of Contents
- [Overview](#overview)
- [Pre-Publishing Checklist](#pre-publishing-checklist)
- [Version Management](#version-management)
- [Publishing to GitHub](#publishing-to-github)
- [Testing the Published Template](#testing-the-published-template)
- [Distribution Methods](#distribution-methods)
- [Maintenance](#maintenance)
- [Release Process](#release-process)

## Overview

The TAVERN template is distributed via Git repositories. Users generate projects using `cargo-generate` pointing to the Git repository URL.

### Distribution Methods

1. **GitHub Repository** (Primary)
   - Most common method
   - Users: `cargo generate --git https://github.com/Drew-Chase/tavern-cargo-template`

2. **Cargo Favorites** (Secondary)
   - Users add to `~/.cargo/cargo-generate.toml`
   - Shorthand generation: `cargo generate tavern`

3. **Git Clone + Local** (Development)
   - Clone and generate locally
   - For testing and development

## Pre-Publishing Checklist

Before publishing a new version, verify:

### Documentation
- [ ] README.md is up-to-date with current features
- [ ] DEVELOPMENT.md has accurate development instructions
- [ ] TESTING.md includes all test scenarios
- [ ] PACKAGING.md (this file) is current
- [ ] All inline code comments are accurate
- [ ] CHANGELOG.md is updated with changes (if present)

### Template Configuration
- [ ] `cargo-generate.toml` has correct version
- [ ] All placeholders are documented
- [ ] Conditional logic is correct
- [ ] File exclusions are appropriate
- [ ] Regex patterns validate correctly

### Template Files
- [ ] All Liquid syntax is correct
- [ ] No syntax errors in template files
- [ ] Placeholder usage is consistent
- [ ] No hardcoded values that should be placeholders
- [ ] All backend variants have appropriate files

### Cleanup Scripts
- [ ] `.cargo-generate-cleanup.rhai` handles all backends
- [ ] File deletion logic is correct
- [ ] No references to non-existent files
- [ ] Script tested with all variants

### Dependencies
- [ ] All dependency versions are specified
- [ ] No deprecated dependencies
- [ ] Version constraints are appropriate
- [ ] Security vulnerabilities addressed

### Testing
- [ ] All automated tests pass (`./test-generation.sh`)
- [ ] Manual testing completed for all variants
- [ ] Generated projects build successfully
- [ ] Dependencies install without errors
- [ ] Development mode works for all variants
- [ ] Production builds work for all variants

### Files to Exclude
- [ ] `.genignore` is comprehensive
- [ ] Test output directory excluded
- [ ] Development files excluded
- [ ] No sensitive information in repo
- [ ] No large binary files

## Version Management

### Semantic Versioning

Use Semantic Versioning (SemVer): `MAJOR.MINOR.PATCH`

- **MAJOR**: Breaking changes (incompatible API changes)
  - Example: Removing a backend variant, changing placeholder names
- **MINOR**: New features (backward-compatible)
  - Example: Adding a new backend variant, new optional placeholders
- **PATCH**: Bug fixes (backward-compatible)
  - Example: Fixing template syntax, updating dependencies

### Where to Update Version

Update version in these files:

**1. cargo-generate.toml**
```toml
[template]
cargo_generate_version = ">=0.10.0"
# Add a version comment
# Template Version: 2.1.0
```

**2. Package files (in templates)**
```json
// package.json
{
  "version": "2.1.0"
}
```

```toml
# Cargo.toml
[package]
version = "2.1.0"
```

**3. Git Tags**
```bash
git tag -a v2.1.0 -m "Release version 2.1.0"
git push origin v2.1.0
```

### Maintaining a CHANGELOG

Create `CHANGELOG.md` following [Keep a Changelog](https://keepachangelog.com/):

```markdown
# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

## [2.1.0] - 2024-01-15

### Added
- New backend variant: Python/FastAPI
- Support for environment variable configuration
- Dark mode preference persistence

### Changed
- Updated React to 18.3.1
- Improved theme switching animation

### Fixed
- Fixed Tauri build on Windows
- Resolved PHP OpenSSL extension issue

### Security
- Updated dependencies with security vulnerabilities

## [2.0.0] - 2023-12-01

### Changed
- **BREAKING**: Renamed placeholder `project_name` to `crate_name`
- **BREAKING**: Removed deprecated "express" backend (use "nodejs")

### Added
- Initial public release
```

## Publishing to GitHub

### Initial Setup

**1. Create GitHub Repository:**
```bash
# On GitHub.com
# Create new repository: tavern-cargo-template
# Don't initialize with README (already exists)
```

**2. Link Local Repository:**
```bash
cd tavern-cargo-template

# Add remote
git remote add origin https://github.com/Drew-Chase/tavern-cargo-template.git

# Push to GitHub
git branch -M master
git push -u origin master
```

**3. Configure Repository:**
- Add description: "A cargo-generate template for full-stack applications"
- Add topics: `rust`, `typescript`, `react`, `template`, `cargo-generate`, `actix`, `tauri`, `laravel`, `nodejs`
- Choose license: GPL-3.0-or-later
- Enable Issues for bug reports

### Publishing Updates

**1. Make Changes:**
```bash
# Create feature branch
git checkout -b feature/new-backend

# Make your changes
# Edit files...

# Test thoroughly
./test-generation.sh

# Commit changes
git add .
git commit -m "Add new backend variant: Python/FastAPI"
```

**2. Update Documentation:**
```bash
# Update relevant docs
vim README.md
vim CHANGELOG.md

git add README.md CHANGELOG.md
git commit -m "Update documentation for new features"
```

**3. Create Pull Request:**
```bash
# Push feature branch
git push origin feature/new-backend

# On GitHub: Create Pull Request
# Review changes, run CI tests
# Merge when approved
```

**4. Tag Release:**
```bash
# Switch to master
git checkout master
git pull origin master

# Create annotated tag
git tag -a v2.1.0 -m "Release version 2.1.0

- Added Python/FastAPI backend
- Updated dependencies
- Fixed Tauri Windows build"

# Push tag
git push origin v2.1.0
```

**5. Create GitHub Release:**
- Go to repository on GitHub
- Click "Releases" > "Create a new release"
- Choose tag: `v2.1.0`
- Release title: "TAVERN Template v2.1.0"
- Description: Copy from CHANGELOG.md
- Attach any additional files (optional)
- Click "Publish release"

## Testing the Published Template

After publishing, test that users can generate projects:

### Test from GitHub (HTTPS)
```bash
cargo generate --git https://github.com/Drew-Chase/tavern-cargo-template --name test-project
```

### Test from GitHub (SSH)
```bash
cargo generate --git git@github.com:Drew-Chase/tavern-cargo-template.git --name test-project
```

### Test Specific Tag
```bash
cargo generate --git https://github.com/Drew-Chase/tavern-cargo-template \
  --tag v2.1.0 \
  --name test-project
```

### Test Specific Branch
```bash
cargo generate --git https://github.com/Drew-Chase/tavern-cargo-template \
  --branch develop \
  --name test-project
```

## Distribution Methods

### Method 1: Direct Git URL (Recommended for Users)

Users run:
```bash
cargo generate --git https://github.com/Drew-Chase/tavern-cargo-template
```

**Pros:**
- Always uses latest version
- No local configuration needed
- Works for any Git host (GitHub, GitLab, etc.)

**Cons:**
- Long command
- Requires internet connection

### Method 2: Cargo Favorites (Power Users)

**Setup:**

Create or edit `~/.cargo/cargo-generate.toml`:

```toml
[favorites.tavern]
description = "TAVERN Stack Template - TypeScript, Actix/Tauri, Vite, Embedded Rust, Node.js"
git = "https://github.com/Drew-Chase/tavern-cargo-template"
branch = "master"
```

Or with specific tag:
```toml
[favorites.tavern]
description = "TAVERN Stack Template"
git = "https://github.com/Drew-Chase/tavern-cargo-template"
tag = "v2.1.0"
```

**Usage:**
```bash
# Short command!
cargo generate tavern

# List favorites
cargo generate --list-favorites
```

**Document in README:**
Add instructions for users to add to favorites:
```markdown
## Quick Access

Add to your cargo favorites for easy access:

**Linux/macOS:**
```bash
cat >> ~/.cargo/cargo-generate.toml << 'EOF'
[favorites.tavern]
description = "TAVERN Stack Template"
git = "https://github.com/Drew-Chase/tavern-cargo-template"
EOF
```

**Windows PowerShell:**
```powershell
Add-Content "$env:USERPROFILE\.cargo\cargo-generate.toml" @"
[favorites.tavern]
description = "TAVERN Stack Template"
git = "https://github.com/Drew-Chase/tavern-cargo-template"
"@
```
```

### Method 3: Local Clone

For template developers:
```bash
git clone https://github.com/Drew-Chase/tavern-cargo-template.git
cd tavern-cargo-template
cargo generate --git . --name my-project
```

## Maintenance

### Regular Updates

**Monthly:**
- [ ] Check for dependency updates
- [ ] Review open issues
- [ ] Update security patches

**Quarterly:**
- [ ] Major dependency updates (React, Actix, etc.)
- [ ] Review and update documentation
- [ ] Check for deprecated features
- [ ] Test on latest Rust/Node versions

**Yearly:**
- [ ] Major version updates
- [ ] Architecture review
- [ ] Performance optimization
- [ ] User survey/feedback

### Dependency Updates

**Update Node.js dependencies:**
```bash
# Check for updates
npm outdated

# Update package.json
# Test all variants
./test-generation.sh
```

**Update Rust dependencies:**
```bash
# Check for updates
cargo outdated

# Update Cargo.toml files
# Test all variants
./test-generation.sh
```

**Update PHP dependencies:**
```bash
# Check composer.json
# Test PHP variant
```

### Handling Issues

**Bug Reports:**
1. Reproduce the issue
2. Create test case
3. Fix in feature branch
4. Test thoroughly
5. Create PR and merge
6. Release patch version

**Feature Requests:**
1. Evaluate feasibility
2. Discuss in issue
3. Create RFC if major change
4. Implement in feature branch
5. Document thoroughly
6. Release minor version

**Security Issues:**
1. Assess severity
2. Fix immediately
3. Release patch ASAP
4. Notify users if critical
5. Document in CHANGELOG

## Release Process

### Standard Release Workflow

**1. Pre-Release (1-2 days before):**
```bash
# Update version numbers
vim cargo-generate.toml
vim package.json
vim Cargo.toml

# Update documentation
vim README.md
vim CHANGELOG.md

# Run full test suite
./test-generation.sh

# Test all backends manually
# Test on Windows, Mac, Linux

# Commit version bumps
git add .
git commit -m "Bump version to 2.1.0"
```

**2. Release Day:**
```bash
# Ensure clean state
git status

# Create and push tag
git tag -a v2.1.0 -m "Release v2.1.0"
git push origin master
git push origin v2.1.0

# Create GitHub release
# Go to GitHub.com and create release
```

**3. Post-Release:**
```bash
# Test published template
cargo generate --git https://github.com/Drew-Chase/tavern-cargo-template

# Monitor issues for problems
# Announce on social media / forums
# Update any external documentation
```

### Hotfix Release Workflow

For critical bugs:

```bash
# Create hotfix branch from tag
git checkout -b hotfix/critical-bug v2.1.0

# Fix the bug
# Test thoroughly

# Commit fix
git commit -m "Fix critical bug in cleanup script"

# Merge to master
git checkout master
git merge hotfix/critical-bug

# Create patch release
git tag -a v2.1.1 -m "Hotfix: Critical cleanup script bug"
git push origin master v2.1.1

# Create GitHub release
```

## Best Practices

1. **Always test before publishing** - Use test scripts
2. **Document all changes** - CHANGELOG.md is essential
3. **Use semantic versioning** - Clear version meaning
4. **Tag all releases** - Allows users to pin versions
5. **Write descriptive commit messages** - Future you will thank you
6. **Keep documentation current** - Documentation is part of the product
7. **Respond to issues promptly** - Even if just acknowledging
8. **Test on multiple platforms** - Windows, Mac, Linux
9. **Maintain backward compatibility** - When possible
10. **Communicate breaking changes** - Clearly and in advance

## Troubleshooting

### Template Generation Fails After Publishing

**Check:**
- Git tag pushed correctly: `git ls-remote --tags origin`
- Repository is public (if intended)
- `.genignore` not excluding required files
- `cargo-generate.toml` syntax is valid

**Fix:**
```bash
# Delete bad tag
git tag -d v2.1.0
git push origin :refs/tags/v2.1.0

# Fix issues and re-tag
git tag -a v2.1.0 -m "Fixed version"
git push origin v2.1.0
```

### Users Report Missing Files

**Check:**
- `.genignore` not too aggressive
- Cleanup script not deleting required files
- Conditional logic in cargo-generate.toml

**Fix:**
- Update `.genignore`
- Test generation thoroughly
- Release hotfix

### Dependency Conflicts

**Check:**
- Version constraints too strict
- Incompatible dependency versions
- Platform-specific dependencies

**Fix:**
- Relax version constraints
- Test on clean system
- Document requirements

## Resources

- [DEVELOPMENT.md](DEVELOPMENT.md) - Development guide
- [TESTING.md](TESTING.md) - Testing guide
- [cargo-generate docs](https://cargo-generate.github.io/cargo-generate/)
- [Semantic Versioning](https://semver.org/)
- [Keep a Changelog](https://keepachangelog.com/)
- [GitHub Releases](https://docs.github.com/en/repositories/releasing-projects-on-github)

## Support

For questions about packaging and distribution:
- Open an issue: https://github.com/Drew-Chase/tavern-cargo-template/issues
- Tag with: `question`, `documentation`, or `distribution`

---

**Happy publishing!**
