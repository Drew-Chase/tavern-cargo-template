# TAVERN Stack Template

A comprehensive cargo-generate template for creating full-stack applications with **T**ypeScript, **A**ctix/Tauri, **V**ite, **E**mbedded **R**ust, and **N**ode.js. Choose from multiple backend options: Actix-web (Rust), Tauri (Desktop), Vanilla (React-only), Node.js/Express, or PHP/Laravel.

## 🚀 Features

- **Single Unified Template**: No code duplication - one frontend codebase for all backends
- **Modern Frontend Stack**: React 18+ with TypeScript, Vite, and TailwindCSS
- **Component Library**: HeroUI React components for beautiful UIs
- **Theme Support**: Built-in dark/light/system theme switching with Framer Motion animations
- **5 Backend Options**: Choose Actix, Tauri, Vanilla, Node.js, or PHP at generation time
- **Conditional Generation**: Only generates files needed for your chosen backend
- **Development Tools**: ESLint, TypeScript, and hot-reload development
- **Production Ready**: Optimized builds for both frontend and backend

## 📦 Template Variants

All templates use the **shared frontend stack**: React + TypeScript + Vite + TailwindCSS + HeroUI with built-in theme switching and responsive design.

### 🌐 Actix Variant
- **Backend**: Actix-web (Rust) server with REST API endpoints
- **Use case**: High-performance web applications, REST APIs, server-side applications
- **Features**: Static file serving, JSON APIs, embedded frontend, blazing-fast performance
- **Port**: Configurable (default: 1421)

### 🖥️ Tauri Variant
- **Backend**: Tauri for cross-platform desktop applications
- **Use case**: Native desktop applications with web technologies
- **Features**: System integration, native performance, small bundle size, secure
- **Platform**: Windows, macOS, Linux

### ⚡ Vanilla Variant
- **Backend**: None (frontend only)
- **Use case**: SPAs, static sites, frontend-only applications, prototyping
- **Features**: Pure React application with Vite dev server
- **Port**: 5173 (Vite default)

### 🟢 Node.js Variant
- **Backend**: Express.js (Node.js) server with REST API endpoints
- **Use case**: Node.js web applications, JavaScript-based backends, rapid development
- **Features**: Express server, API routing, concurrent dev servers, production static serving
- **Port**: Configurable (default: 3001)

### 🐘 PHP Variant
- **Backend**: Laravel (PHP) framework with Vite integration
- **Use case**: PHP web applications, Laravel-based projects, enterprise applications
- **Features**: Laravel routing, API endpoints, Blade integration, Laravel Vite plugin
- **Port**: Configurable (default: 8000)

## 🛠️ Prerequisites

### All Variants
- [Node.js](https://nodejs.org/) (v18+)
- [cargo-generate](https://github.com/cargo-generate/cargo-generate)

### Variant-Specific Requirements

#### Actix & Tauri Variants
- [Rust](https://rustup.rs/) (latest stable, edition 2024)

#### PHP Variant
- [PHP](https://www.php.net/) (v8.2+)
- [Composer](https://getcomposer.org/)

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
- **Backend**: Choose from "actix", "tauri", "vanilla", "nodejs", or "php"
- **Backend-specific options**: Port numbers (actix/nodejs/php), app config (tauri), etc.

**Note**: The template uses conditional generation - only the files needed for your chosen backend will be included in the generated project. No unnecessary files or duplication!

### Project Setup

After generation, navigate to your project directory:

```bash
cd your-project-name
```

#### For Actix Variant:

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Start development servers:**
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

1. **Install dependencies:**
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

#### For Vanilla Variant:

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Start development:**
   ```bash
   npm run dev
   ```

3. **Build for production:**
   ```bash
   npm run build
   ```

#### For Node.js Variant:

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Start development:**
   ```bash
   # Runs both frontend and backend concurrently
   npm run dev
   ```

3. **Build and start production:**
   ```bash
   npm run build
   npm start
   ```

#### For PHP Variant:

1. **Install dependencies:**
   ```bash
   composer install
   npm install
   ```

2. **Setup environment:**
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

3. **Start development:**
   ```bash
   # Terminal 1: Start Laravel server
   php artisan serve

   # Terminal 2: Start Vite dev server
   npm run dev
   ```

4. **Build for production:**
   ```bash
   npm run build
   ```

## 📁 Project Structure

### Unified Template Structure
The template uses a **single unified structure** with conditional file inclusion. When you generate a project, only the files needed for your chosen backend are included:

**Common Frontend (Always Included)**:
```
your-project/
├── src/                         # React frontend (always included)
│   ├── assets/
│   │   ├── components/          # Navigation, etc.
│   │   ├── css/                 # Roboto font + theme
│   │   ├── pages/               # Home, About
│   │   └── providers/           # ThemeProvider
│   └── main.tsx                 # Entry point
├── index.html                   # HTML template
├── package.json                 # Dependencies (conditional)
├── vite.config.ts               # Vite config (conditional)
├── tailwind.config.js           # Tailwind config
├── tsconfig.json                # TypeScript config
├── .eslintrc.cjs                # ESLint config
└── postcss.config.js            # PostCSS config
```

**Backend-Specific Files (Conditionally Included)**:

- **Actix**: `src-actix/`, `Cargo.toml`
- **Tauri**: `src-tauri/`, `Cargo.toml`
- **Vanilla**: *(no backend files)*
- **Node.js**: `server/`
- **PHP**: `app/`, `routes/`, `resources/`, `public/`, `bootstrap/`, `composer.json`, `.env.example`

### Example: Generated Actix Project
```
my-actix-app/
├── src/                    # React frontend
├── src-actix/             # Actix backend (included)
├── Cargo.toml             # Rust config
├── package.json           # With actix scripts
└── vite.config.ts         # With actix proxy
# Note: No src-tauri/, server/, app/, etc.
```

### Example: Generated Vanilla Project
```
my-vanilla-app/
├── src/                    # React frontend
├── package.json           # Minimal deps
└── vite.config.ts         # Basic config
# Note: No backend directories at all
```

## 🎨 Tech Stack

### Frontend (Shared Across All Templates)
- **React 18+**: Modern React with hooks and functional components
- **TypeScript**: Type-safe JavaScript development
- **Vite**: Fast build tool and development server
- **TailwindCSS**: Utility-first CSS framework
- **HeroUI**: Beautiful React component library
- **Framer Motion**: Smooth animations and transitions
- **Iconify**: Comprehensive icon library
- **React Router**: Client-side routing

### Backend Options

#### Actix (Rust)
- **Actix-web**: Fast and powerful web framework
- **Serde**: Serialization/deserialization
- **Actix-files**: Static file serving
- **Embedded frontend**: Built into binary

#### Tauri (Desktop)
- **Tauri**: Secure desktop app framework
- **Native APIs**: System integration
- **Small Bundle**: Efficient resource usage

#### Node.js (Express)
- **Express.js**: Fast, minimalist web framework
- **Concurrent dev**: Vite + Nodemon
- **Production**: Static file serving

#### PHP (Laravel)
- **Laravel 11**: Modern PHP framework
- **Laravel Vite Plugin**: Seamless frontend integration
- **Blade Templates**: Server-side rendering option

## 🔧 Development Scripts

### Actix Variant
- `npm run dev` - Start Vite dev server
- `npm run watch` - Auto-reload Rust server
- `npm run build` - Build frontend and backend
- `npm run lint` - Run ESLint

### Tauri Variant
- `npm run dev` - Start Vite dev server
- `npm run tauri-dev` - Start Tauri development
- `npm run tauri-build` - Build Tauri app

### Vanilla Variant
- `npm run dev` - Start Vite dev server
- `npm run build` - Build for production
- `npm run preview` - Preview production build

### Node.js Variant
- `npm run dev` - Start both frontend and backend
- `npm run build` - Build frontend
- `npm start` - Start production server
- `npm run dev:frontend` - Start only frontend
- `npm run dev:backend` - Start only backend

### PHP Variant
- `npm run dev` - Start Vite dev server
- `npm run build` - Build frontend
- `php artisan serve` - Start Laravel server

## 🌟 Features Included

- **🎨 Modern UI**: Clean, responsive design with HeroUI components
- **🌙 Theme Support**: Dark/light/system theme switching with smooth transitions
- **📱 Responsive**: Mobile-first responsive design
- **⚡ Fast Development**: Hot-reload for both frontend and backend
- **🔒 Type Safety**: Full TypeScript coverage
- **🏗️ Production Ready**: Optimized builds and deployment configs
- **🧪 Development Tools**: ESLint, TypeScript compiler, and more
- **🔄 Zero Duplication**: Single frontend codebase - no copied files between backends
- **🎯 Smart Generation**: Conditionally includes only what your backend needs
- **📦 Easy Maintenance**: Update once, all backends benefit from changes

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

### Frontend
- [React Documentation](https://react.dev/)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [Vite Documentation](https://vitejs.dev/)
- [TailwindCSS Documentation](https://tailwindcss.com/docs)
- [HeroUI Documentation](https://heroui.com/)

### Backend
- [Actix-web Documentation](https://actix.rs/)
- [Tauri Documentation](https://tauri.app/)
- [Express.js Documentation](https://expressjs.com/)
- [Laravel Documentation](https://laravel.com/docs)

## 🚀 Getting Help

- Check the [Issues](https://github.com/yourusername/tavern-cargo-template/issues) page
- Read the documentation of the respective frameworks
- Join the community discussions

---

Happy coding! 🎉
