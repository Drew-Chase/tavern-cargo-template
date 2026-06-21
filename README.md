# TAVERN Stack Template

A comprehensive cargo-generate template for creating full-stack applications with **T**ypeScript, **A**ctix/Tauri, **V**ite, **E**mbedded **R**ust, and **N**ode.js.

## 🚀 Features

- **Modern Frontend Stack**: React 19 with TypeScript, Vite, and TailwindCSS v4
- **Component Library**: HeroUI v3 React components for beautiful UIs
- **Theme Support**: Built-in dark/light theme switching
- **Development Tools**: ESLint, TypeScript, and hot-reload development
- **Production Ready**: Optimized builds for both frontend and backend

## 📦 Template Variants

### 🌐 Actix Variant
- **Backend**: Actix-web server with REST API endpoints
- **Frontend**: React + TypeScript + Vite + TailwindCSS + HeroUI
- **Use case**: Web applications, REST APIs, server-side applications
- **Features**: Static file serving, JSON APIs, embedded frontend

### 🖥️ Tauri Variant
- **Backend**: Tauri for cross-platform desktop applications
- **Frontend**: React + TypeScript + Vite + TailwindCSS + HeroUI
- **Use case**: Native desktop applications with web technologies
- **Features**: System integration, native performance, small bundle size

## 🛠️ Prerequisites

- [Rust](https://rustup.rs/) (latest stable, edition 2024)
- [Node.js](https://nodejs.org/) (v18+)
- [cargo-generate](https://github.com/cargo-generate/cargo-generate)

### Install cargo-generate

```bash
cargo install cargo-generate
```

### Additional Requirements for Tauri

For the Tauri variant, you'll also need platform-specific dependencies:

**Windows:**
```bash
# Install WebView2 (usually pre-installed on Windows 10/11)
# Install Microsoft C++ Build Tools
```

**macOS:**
```bash
xcode-select --install
```

**Linux:**
```bash
sudo apt update
sudo apt install libwebkit2gtk-4.0-dev \
    build-essential \
    curl \
    wget \
    file \
    libssl-dev \
    libgtk-3-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev
```

## 🚀 Quick Start

### Generate a New Project

```bash
cargo generate --git https://github.com/drew-chase/tavern-cargo-template
```

The template will prompt you for:
- **Project name**: The name of your project (snake_case recommended)
- **Project description**: Description for your project
- **Author**: Your name or organization
- **Repository**: Repository URL (optional)
- **Template variant**: Choose between "actix" or "tauri"

### Project Setup

After generation, navigate to your project directory:

```bash
cd your-project-name
```

#### For Actix Variant:

1. **Install frontend dependencies:**
   ```bash
   npm install
   ```

2. **Start development server:**
   ```bash
   # Terminal 1: Start the Rust backend with auto-reload
   npm run watch
   
   # Terminal 2: Start the Vite frontend dev server
   npm run dev
   ```

3. **Build for production:**
   ```bash
   npm run build
   ```

#### For Tauri Variant:

1. **Install frontend dependencies:**
   ```bash
   npm install
   ```

2. **Start development:**
   ```bash
   npm run tauri-dev
   ```

3. **Build for production:**
   ```bash
   npm run tauri-build
   ```

## 📁 Project Structure

### Actix Variant
```
your-project/
├── src/                    # React frontend source
│   ├── assets/
│   │   ├── components/     # React components
│   │   ├── css/           # Stylesheets
│   │   ├── pages/         # Page components
│   │   └── providers/     # Context providers
│   ├── main.tsx           # React entry point
│   └── vite-env.d.ts      # Vite type definitions
├── src-actix/             # Rust backend source
│   ├── main.rs            # Server entry point
│   ├── lib.rs             # Library modules
│   ├── build.rs           # Build script
│   └── *.rs               # API endpoints and utilities
├── package.json           # Node.js dependencies
├── Cargo.toml            # Rust dependencies
└── vite.config.ts        # Vite configuration (TailwindCSS v4 plugin)
```

### Tauri Variant
```
your-project/
├── src/                    # React frontend source
│   ├── assets/
│   │   ├── components/     # React components
│   │   ├── css/           # Stylesheets
│   │   ├── pages/         # Page components
│   │   └── providers/     # Context providers
│   ├── main.tsx           # React entry point
│   └── vite-env.d.ts      # Vite type definitions
├── src-tauri/             # Tauri backend source
│   ├── src/
│   │   ├── main.rs        # Tauri entry point
│   │   └── lib.rs         # Tauri commands
│   ├── Cargo.toml         # Tauri dependencies
│   ├── tauri.conf.json    # Tauri configuration
│   ├── capabilities/      # Tauri permissions
│   └── icons/             # Application icons
├── package.json           # Node.js dependencies
└── vite.config.ts        # Vite configuration (TailwindCSS v4 plugin)
```

## 🎨 Tech Stack

### Frontend
- **React 19**: Modern React with hooks and functional components
- **TypeScript**: Type-safe JavaScript development
- **Vite**: Fast build tool and development server
- **TailwindCSS v4**: Utility-first CSS framework (CSS-first config)
- **HeroUI v3**: Beautiful React component library built on React Aria
- **Iconify**: Comprehensive icon library

### Backend (Actix)
- **Actix-web**: Fast and powerful web framework
- **Serde**: Serialization/deserialization
- **Actix-files**: Static file serving
- **Futures**: Async runtime utilities

### Backend (Tauri)
- **Tauri**: Secure desktop app framework
- **Native APIs**: System integration capabilities
- **Small Bundle**: Efficient resource usage

## 🔧 Development Scripts

### Actix Variant
- `npm run dev` - Start Vite development server
- `npm run build-frontend` - Build React frontend
- `npm run build-api` - Build Rust backend
- `npm run build` - Build both frontend and backend
- `npm run run-api` - Run the Rust server
- `npm run watch` - Auto-reload Rust server on changes
- `npm run lint` - Run ESLint

### Tauri Variant
- `npm run dev` - Start Vite development server
- `npm run build` - Build React frontend
- `npm run tauri-dev` - Start Tauri development mode
- `npm run tauri-build` - Build Tauri application

## 🌟 Features Included

- **🎨 Modern UI**: Clean, responsive design with HeroUI components
- **🌙 Theme Support**: Dark/light mode with smooth transitions
- **📱 Responsive**: Mobile-first responsive design
- **⚡ Fast Development**: Hot-reload for both frontend and backend
- **🔒 Type Safety**: Full TypeScript coverage
- **🏗️ Production Ready**: Optimized builds and deployment configs
- **🧪 Development Tools**: ESLint, TypeScript compiler, and more

## Cargo Favorites
You can also add this template to your Cargo favorites for easy access, add the `cargo-generate.toml` in the cargo home directory
- Windows `%USERPROFILE%\.cargo\`
- macOS/Linux `~/.cargo/`
- or create a new file `~/.cargo/cargo-generate.toml` with the following content:
```toml
[favorites.tavern]
description = "A cargo-generate template for creating full-stack applications with TypeScript, React, Vite, and Rust backends."
git = "https://github.com/Drew-Chase/tavern-cargo-template"
vcs = "Git"
init = false
overwrite = true
```

## 📝 License

GPL-3.0-or-later

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📚 Documentation

For more detailed documentation on the frameworks used:

- [React Documentation](https://react.dev/)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [Vite Documentation](https://vitejs.dev/)
- [TailwindCSS Documentation](https://tailwindcss.com/docs)
- [HeroUI Documentation](https://heroui.com/)
- [Actix-web Documentation](https://actix.rs/)
- [Tauri Documentation](https://tauri.app/)

## 🚀 Getting Help

- Check the [Issues](https://github.com/yourusername/tavern-cargo-template/issues) page
- Read the documentation of the respective frameworks
- Join the community discussions

---

Happy coding! 🎉
