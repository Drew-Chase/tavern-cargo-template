# TAVERN Stack Template

A cargo-generate template for creating full-stack applications with TypeScript, React, Vite, and Rust backends.

## Template Variants

This template provides two variants:

### Actix Variant
- **Backend**: Actix-web server with REST API endpoints
- **Frontend**: React + TypeScript + Vite + TailwindCSS
- **Use case**: Web applications, APIs, server-side applications

### Tauri Variant
- **Backend**: Tauri for desktop application development
- **Frontend**: React + TypeScript + Vite + TailwindCSS
- **Use case**: Cross-platform desktop applications

## Usage

### Prerequisites
- [Rust](https://rustup.rs/) (latest stable)
- [Node.js](https://nodejs.org/) (v18+)
- [cargo-generate](https://github.com/cargo-generate/cargo-generate)

Install cargo-generate:
```bash
cargo install cargo-generate
```

### Generate a New Project

```bash
cargo generate --git https://github.com/yourusername/tavern-cargo-template
```

The template will prompt you for:
- **Project name**: The name of your project
- **Project description**: Description for your project
- **Author**: Your name
- **Repository**: Repository URL (optional)
- **Template variant**: Choose between "actix" or "tauri"

#### Actix-specific prompts:
- **API port**: Port for the web server (default: 1421)

#### Tauri-specific prompts:
- **App identifier**: Unique app identifier (e.g., com.yourcompany.appname)
- **Window title**: Desktop application window title
- **Window dimensions**: Width and height for the application window

## Development

### Actix Variant

```bash
cd your-project-name/actix
npm install
npm run watch  # Runs both frontend and backend in development mode
```

The development server will start at `http://localhost:1421` (or your configured port).

Available scripts:
- `npm run dev` - Start Vite development server
- `npm run build-frontend` - Build frontend for production
- `npm run build-api` - Build Rust backend
- `npm run build` - Build both frontend and backend
- `npm run watch` - Watch mode with hot reload

### Tauri Variant

```bash
cd your-project-name/tauri
npm install
npm run tauri-dev  # Runs the desktop application in development mode
```

Available scripts:
- `npm run dev` - Start Vite development server
- `npm run build` - Build frontend for production
- `npm run tauri-dev` - Run desktop app in development mode
- `npm run tauri-build` - Build desktop app for production

## Project Structure

### Actix Variant
```
actix/
├── src-actix/          # Rust backend source
│   ├── main.rs         # Application entry point
│   ├── lib.rs          # Main library code
│   ├── build.rs        # Build script
│   └── ...             # API endpoints and modules
├── src/                # React frontend source
│   ├── main.tsx        # Frontend entry point
│   └── assets/         # Components, pages, styles
├── package.json        # Node.js dependencies and scripts
├── Cargo.toml          # Rust dependencies
└── vite.config.ts      # Vite configuration
```

### Tauri Variant
```
tauri/
├── src-tauri/          # Rust backend for Tauri
│   ├── src/            # Tauri application code
│   ├── Cargo.toml      # Rust dependencies
│   ├── tauri.conf.json # Tauri configuration
│   └── build.rs        # Build script
├── src/                # React frontend source
│   ├── main.tsx        # Frontend entry point
│   └── assets/         # Components, pages, styles
├── package.json        # Node.js dependencies and scripts
└── vite.config.ts      # Vite configuration
```

## Tech Stack

- **Frontend**: React 18, TypeScript, Vite, TailwindCSS, HeroUI
- **Backend (Actix)**: Actix-web, Serde, Anyhow, Log
- **Backend (Tauri)**: Tauri 2.0, Serde
- **Development**: Hot reload, ESLint, PostCSS

## Features

- ✅ Hot reload for both frontend and backend
- ✅ TypeScript support with strict configuration
- ✅ TailwindCSS for styling
- ✅ Modern React with functional components
- ✅ Error handling and logging
- ✅ Production-ready build process
- ✅ Cross-platform support

## License

GPL-3.0-or-later
