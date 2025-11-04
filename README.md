# {{crate_name}}

{{project_description}}

{% if backend == "actix" -%}
A full-stack web application built with **Actix-web** (Rust) backend and **React + TypeScript** frontend.

## 🚀 Tech Stack

**Frontend:**
- React 18+ with TypeScript
- Vite for fast development and optimized builds
- TailwindCSS for styling
- HeroUI component library
- Framer Motion for animations

**Backend:**
- Actix-web (Rust) - High-performance web framework
- Serde for JSON serialization
- Static file serving with embedded frontend

## 📋 Prerequisites

- [Rust](https://rustup.rs/) (latest stable)
- [Node.js](https://nodejs.org/) (v18+)
- [pnpm](https://pnpm.io/), npm, or yarn

## 🛠️ Development

### Install Dependencies

```bash
# Install Node.js dependencies
npm install
# or
pnpm install
# or
yarn install
```

### Run Development Servers

You'll need two terminal windows:

**Terminal 1 - Backend (with auto-reload):**
```bash
npm run watch
# or
cargo watch -q -c -w src-actix/ -x run
```

**Terminal 2 - Frontend:**
```bash
npm run dev
```

- Frontend: http://localhost:5173
- Backend API: http://localhost:{{api_port}}

The frontend dev server proxies API requests to the backend.

## 🧪 Testing

```bash
# Run Rust tests
cargo test

# Run frontend tests (if configured)
npm test

# Check Rust code
cargo check

# Lint frontend
npm run lint
```

## 📦 Building for Production

### Build Everything

```bash
npm run build
```

This command:
1. Builds the frontend (`npm run build-frontend`)
   - Compiles TypeScript
   - Bundles with Vite
   - Outputs to `dist/`
2. Builds the backend (`npm run build-api`)
   - Compiles Rust in release mode with optimizations
   - Embeds frontend assets into binary

### Build Output

**Backend binary:** `target/release/{{crate_name}}` (or `{{crate_name}}.exe` on Windows)

**Frontend assets:** Embedded in the backend binary

### Run Production Build

```bash
# The binary includes the frontend
./target/release/{{crate_name}}

# Or on Windows
.\target\release\{{crate_name}}.exe
```

Visit http://localhost:{{api_port}}

### Deployment

The `target/release/{{crate_name}}` binary is self-contained and can be deployed anywhere:

```bash
# Copy binary to server
scp target/release/{{crate_name}} user@server:/opt/app/

# Run on server
./{{crate_name}}
```

Configure the port via environment variable or modify `src-actix/main.rs`.

{%- elsif backend == "tauri" -%}
A cross-platform desktop application built with **Tauri** (Rust) and **React + TypeScript** frontend.

## 🚀 Tech Stack

**Frontend:**
- React 18+ with TypeScript
- Vite for fast development
- TailwindCSS for styling
- HeroUI component library
- Framer Motion for animations

**Backend:**
- Tauri 2.0 - Secure desktop app framework
- Rust for native functionality
- Native system APIs

## 📋 Prerequisites

- [Rust](https://rustup.rs/) (latest stable)
- [Node.js](https://nodejs.org/) (v18+)
- [pnpm](https://pnpm.io/) (recommended), npm, or yarn
- Platform-specific dependencies (see below)

### Platform-Specific Setup

**Windows:**
- WebView2 (usually pre-installed on Windows 10/11)
- Microsoft C++ Build Tools

**macOS:**
```bash
xcode-select --install
```

**Linux (Ubuntu/Debian):**
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

## 🛠️ Development

### Install Dependencies

```bash
npm install
# or
pnpm install
# or
yarn install
```

### Run Development

```bash
npm run tauri-dev
```

This starts both the frontend dev server and opens the Tauri window.

## 🧪 Testing

```bash
# Run Rust tests
cd src-tauri
cargo test

# Run frontend tests (if configured)
npm test

# Lint frontend
npm run lint
```

## 📦 Building for Production

### Build Application

```bash
npm run tauri-build
```

This command:
1. Builds the frontend in production mode
2. Compiles the Rust backend
3. Packages everything into platform-specific installers

### Build Output

**Location:** `src-tauri/target/release/bundle/`

**Platform-specific builds:**

- **Windows:**
  - `msi/{{crate_name}}_*_x64_en-US.msi` - Windows Installer
  - `nsis/{{crate_name}}_*_x64-setup.exe` - NSIS Installer

- **macOS:**
  - `macos/{{crate_name}}.app` - Application bundle
  - `dmg/{{crate_name}}_*_x64.dmg` - DMG installer

- **Linux:**
  - `deb/{{crate_name}}_*_amd64.deb` - Debian package
  - `appimage/{{crate_name}}_*_amd64.AppImage` - AppImage

### Development Binary

**Location:** `src-tauri/target/release/{{crate_name}}`

```bash
# Run the development binary directly
./src-tauri/target/release/{{crate_name}}
```

### Deployment

Distribute the appropriate installer for each platform from `src-tauri/target/release/bundle/`.

Users simply install the application like any native app.

{%- elsif backend == "vanilla" -%}
A modern single-page application built with **React + TypeScript** and **Vite**.

## 🚀 Tech Stack

- React 18+ with TypeScript
- Vite for fast development and optimized builds
- TailwindCSS for styling
- HeroUI component library
- Framer Motion for animations
- React Router for navigation

## 📋 Prerequisites

- [Node.js](https://nodejs.org/) (v18+)
- npm, [pnpm](https://pnpm.io/), or yarn

## 🛠️ Development

### Install Dependencies

```bash
npm install
# or
pnpm install
# or
yarn install
```

### Run Development Server

```bash
npm run dev
```

Visit http://localhost:5173

The dev server includes:
- Hot Module Replacement (HMR)
- Fast refresh for React
- TypeScript checking
- Automatic browser reload

## 🧪 Testing

```bash
# Run tests (if configured)
npm test

# Type checking
npx tsc --noEmit

# Lint code
npm run lint
```

## 📦 Building for Production

### Build Application

```bash
npm run build
```

This command:
1. Compiles TypeScript
2. Bundles and optimizes assets with Vite
3. Minifies code for production

### Build Output

**Location:** `dist/`

**Contents:**
- `dist/index.html` - Main HTML file
- `dist/assets/` - Bundled JavaScript, CSS, and assets

### Preview Production Build

```bash
npm run preview
```

Visit http://localhost:4173

### Deployment

Deploy the contents of the `dist/` directory to any static hosting service:

#### Netlify
```bash
# Install Netlify CLI
npm install -g netlify-cli

# Deploy
netlify deploy --prod --dir=dist
```

#### Vercel
```bash
# Install Vercel CLI
npm install -g vercel

# Deploy
vercel --prod
```

#### GitHub Pages
```bash
# Add to package.json scripts:
"deploy": "vite build && gh-pages -d dist"

# Deploy
npm run deploy
```

#### Traditional Hosting
Upload the `dist/` directory contents to your web server's public folder.

{%- elsif backend == "nodejs" -%}
A full-stack web application built with **Express.js** (Node.js) backend and **React + TypeScript** frontend.

## 🚀 Tech Stack

**Frontend:**
- React 18+ with TypeScript
- Vite for fast development and optimized builds
- TailwindCSS for styling
- HeroUI component library
- Framer Motion for animations

**Backend:**
- Express.js - Fast, minimalist web framework
- Node.js runtime
- Static file serving

## 📋 Prerequisites

- [Node.js](https://nodejs.org/) (v18+)
- npm, [pnpm](https://pnpm.io/), or yarn

## 🛠️ Development

### Install Dependencies

```bash
npm install
# or
pnpm install
# or
yarn install
```

### Run Development Servers

**Run both frontend and backend concurrently:**
```bash
npm run dev
```

This starts:
- Frontend dev server: http://localhost:5173
- Backend API server: http://localhost:{{api_port}}

**Or run separately:**

**Terminal 1 - Backend:**
```bash
npm run dev:backend
```

**Terminal 2 - Frontend:**
```bash
npm run dev:frontend
```

## 🧪 Testing

```bash
# Run tests (if configured)
npm test

# Type checking
npx tsc --noEmit

# Lint code
npm run lint

# Test backend endpoints
curl http://localhost:{{api_port}}/api/hello
```

## 📦 Building for Production

### Build Frontend

```bash
npm run build
```

This compiles TypeScript and bundles the frontend with Vite.

### Build Output

**Frontend:** `dist/`
- `dist/index.html` - Main HTML file
- `dist/assets/` - Bundled JavaScript, CSS, and assets

**Backend:** `server/index.js` (no build needed for Node.js)

### Run Production Server

```bash
npm start
```

This runs the Express server which:
- Serves the built frontend from `dist/`
- Provides API endpoints
- Listens on http://localhost:{{api_port}}

### Environment Configuration

Create a `.env` file for production settings:

```bash
PORT={{api_port}}
NODE_ENV=production
```

### Deployment

#### Deploy to Heroku
```bash
# Install Heroku CLI
# Login and create app
heroku create

# Deploy
git push heroku master

# Set environment variables
heroku config:set NODE_ENV=production
```

#### Deploy to Railway
```bash
# Install Railway CLI
npm install -g @railway/cli

# Login and deploy
railway login
railway up
```

#### Deploy to VPS
```bash
# Build frontend
npm run build

# Copy files to server
scp -r dist/ server/ package*.json user@server:/opt/app/

# On server
cd /opt/app
npm install --production
npm start
```

#### Using PM2 (Process Manager)
```bash
# Install PM2
npm install -g pm2

# Start application
pm2 start npm --name "{{crate_name}}" -- start

# Save process list
pm2 save

# Setup startup script
pm2 startup
```

{%- elsif backend == "php" -%}
A full-stack web application built with **Laravel** (PHP) framework and **React + TypeScript** frontend.

## 🚀 Tech Stack

**Frontend:**
- React 18+ with TypeScript
- Vite for fast development and optimized builds
- TailwindCSS for styling
- HeroUI component library
- Framer Motion for animations
- Laravel Vite Plugin for seamless integration

**Backend:**
- Laravel 11 - Modern PHP framework
- PHP 8.2+
- Laravel routing and API support

## 📋 Prerequisites

- [PHP](https://www.php.net/) (v8.2+)
- [Composer](https://getcomposer.org/)
- [Node.js](https://nodejs.org/) (v18+)
- npm, [pnpm](https://pnpm.io/), or yarn

### PHP Extensions Required

Ensure these extensions are enabled in your `php.ini`:
- `extension=openssl`
- `extension=pdo_mysql` (or your database driver)
- `extension=mbstring`
- `extension=tokenizer`
- `extension=xml`
- `extension=ctype`
- `extension=json`
- `extension=bcmath`

## 🛠️ Development

### Install Dependencies

```bash
# Install PHP dependencies
composer install

# Install Node.js dependencies
npm install
# or
pnpm install
# or
yarn install
```

### Setup Environment

```bash
# Copy environment file
cp .env.example .env

# Generate application key
php artisan key:generate

# Configure database in .env
# DB_CONNECTION=mysql
# DB_HOST=127.0.0.1
# DB_PORT=3306
# DB_DATABASE={{crate_name}}
# DB_USERNAME=root
# DB_PASSWORD=

# Run migrations (if you have any)
php artisan migrate
```

### Run Development Servers

You'll need two terminal windows:

**Terminal 1 - Laravel Backend:**
```bash
php artisan serve
```

**Terminal 2 - Vite Frontend:**
```bash
npm run dev
```

- Application: http://localhost:{{api_port}}
- Vite dev server: http://localhost:5173 (auto-proxied by Laravel)

## 🧪 Testing

```bash
# Run PHP tests
php artisan test
# or
./vendor/bin/phpunit

# Run frontend tests (if configured)
npm test

# Check PHP syntax
composer check
# or
./vendor/bin/phpstan analyse

# Lint frontend
npm run lint

# Format PHP code (using Laravel Pint)
./vendor/bin/pint
```

## 📦 Building for Production

### Build Frontend Assets

```bash
npm run build
```

This command:
1. Compiles TypeScript
2. Bundles and optimizes assets with Vite
3. Outputs versioned assets with manifest

### Build Output

**Frontend assets:** `public/build/`
- `public/build/manifest.json` - Asset manifest for Laravel
- `public/build/assets/` - Compiled JavaScript, CSS, fonts, images

**Backend:** No compilation needed (PHP is interpreted)

### Prepare for Production

```bash
# Optimize autoloader
composer install --optimize-autoloader --no-dev

# Cache configuration
php artisan config:cache

# Cache routes
php artisan route:cache

# Cache views
php artisan view:cache

# Optimize
php artisan optimize
```

### Environment Configuration

Update `.env` for production:

```bash
APP_ENV=production
APP_DEBUG=false
APP_URL=https://yourdomain.com

# Set secure APP_KEY
php artisan key:generate
```

### Deployment

#### Deploy to Shared Hosting

```bash
# Build assets locally
npm run build

# Upload files to server
# - All files except: .env, node_modules/, vendor/, storage/
# - Make sure storage/ and bootstrap/cache/ are writable

# On server, install dependencies
composer install --optimize-autoloader --no-dev

# Set permissions
chmod -R 755 storage bootstrap/cache
```

#### Deploy to VPS (with Nginx)

```bash
# On server
cd /var/www/{{crate_name}}

# Pull latest code
git pull origin main

# Install dependencies
composer install --no-dev --optimize-autoloader
npm install
npm run build

# Run migrations
php artisan migrate --force

# Clear and cache
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Restart services
sudo systemctl restart php8.2-fpm
sudo systemctl reload nginx
```

**Nginx Configuration Example:**
```nginx
server {
    listen 80;
    server_name yourdomain.com;
    root /var/www/{{crate_name}}/public;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    index index.php;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
```

#### Deploy to Laravel Forge

Laravel Forge handles most of this automatically:
1. Connect your repository
2. Configure environment variables
3. Set deployment script:
```bash
cd /home/forge/{{crate_name}}
git pull origin main
composer install --no-dev --optimize-autoloader
npm install
npm run build
php artisan migrate --force
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan queue:restart
```

#### Deploy to Laravel Vapor (Serverless)

```bash
# Install Vapor CLI
composer require laravel/vapor-cli

# Deploy
vapor deploy production
```

{%- endif %}

## 📁 Project Structure

```
{{crate_name}}/
├── src/                    # React frontend source
│   ├── assets/
│   │   ├── components/    # UI components
│   │   ├── css/           # Styles
│   │   ├── pages/         # Page components
│   │   └── providers/     # Context providers
│   └── main.tsx           # Frontend entry point
{% if backend == "actix" -%}
├── src-actix/             # Actix-web backend
│   ├── main.rs           # Backend entry point
│   └── test_endpoint.rs  # Example API endpoint
├── Cargo.toml            # Rust dependencies
{% elsif backend == "tauri" -%}
├── src-tauri/            # Tauri application
│   ├── src/              # Rust backend code
│   ├── icons/            # Application icons
│   ├── Cargo.toml        # Rust dependencies
│   └── tauri.conf.json   # Tauri configuration
├── Cargo.toml            # Workspace configuration
{% elsif backend == "nodejs" -%}
├── server/               # Express backend
│   └── index.js         # Backend entry point
{% elsif backend == "php" -%}
├── app/                  # Laravel application code
├── routes/               # Laravel routes
├── resources/            # Blade views and resources
├── public/               # Public directory (web root)
├── bootstrap/            # Laravel bootstrap
├── composer.json         # PHP dependencies
{% endif -%}
├── package.json          # Node.js dependencies
├── vite.config.ts        # Vite configuration
├── tsconfig.json         # TypeScript configuration
├── tailwind.config.js    # TailwindCSS configuration
└── README.md             # This file
```

## 🎨 Features

- **Modern UI**: Clean, responsive design with HeroUI components
- **Theme Support**: Dark/light/system theme switching
- **Responsive**: Mobile-first responsive design
- **Fast Development**: Hot-reload for both frontend{% if backend != "vanilla" %} and backend{% endif %}
- **Type Safety**: Full TypeScript coverage
- **Production Ready**: Optimized builds and deployment configs

## 📚 Documentation

### Frontend
- [React Documentation](https://react.dev/)
- [TypeScript Documentation](https://www.typescriptlang.org/docs/)
- [Vite Documentation](https://vitejs.dev/)
- [TailwindCSS Documentation](https://tailwindcss.com/docs)
- [HeroUI Documentation](https://heroui.com/)

### Backend
{% if backend == "actix" -%}
- [Actix-web Documentation](https://actix.rs/)
- [Rust Book](https://doc.rust-lang.org/book/)
{% elsif backend == "tauri" -%}
- [Tauri Documentation](https://tauri.app/)
- [Tauri API Reference](https://tauri.app/v1/api/js/)
{% elsif backend == "nodejs" -%}
- [Express.js Documentation](https://expressjs.com/)
- [Node.js Documentation](https://nodejs.org/docs/)
{% elsif backend == "php" -%}
- [Laravel Documentation](https://laravel.com/docs)
- [Laravel Vite](https://laravel.com/docs/vite)
{% endif -%}

## 🐛 Troubleshooting

{% if backend == "actix" -%}
### Rust Compilation Errors
- Run `cargo clean && cargo build` to rebuild from scratch
- Ensure Rust is up to date: `rustup update`

### Port Already in Use
- Change the port in `src-actix/main.rs`
- Or kill the process using port {{api_port}}
{% elsif backend == "tauri" -%}
### Tauri Build Fails
- Ensure all platform-specific dependencies are installed
- Check Tauri prerequisites: https://tauri.app/v1/guides/getting-started/prerequisites

### WebView Issues
- **Windows**: Update WebView2
- **Linux**: Ensure webkit2gtk is installed
{% elsif backend == "nodejs" -%}
### Port Already in Use
- Change PORT in `.env` file or package.json scripts
- Or kill the process using port {{api_port}}

### Module Not Found
- Delete `node_modules/` and `package-lock.json`
- Run `npm install` again
{% elsif backend == "php" -%}
### Composer Install Fails
- Ensure PHP OpenSSL extension is enabled
- Check `php.ini` for required extensions
- Run `php -m` to list loaded extensions

### Laravel Key Error
- Run `php artisan key:generate`

### Permission Denied
- Run `chmod -R 755 storage bootstrap/cache`
- Ensure web server has write access to these directories

### Vite Not Loading
- Clear Laravel cache: `php artisan cache:clear`
- Rebuild frontend: `npm run build`
{% endif -%}

### Frontend Build Issues
- Clear node modules: `rm -rf node_modules package-lock.json && npm install`
- Clear Vite cache: `rm -rf node_modules/.vite`

## 📝 License

GPL-3.0-or-later

## 👤 Author

{{authors}}

---

Built with [TAVERN Stack Template](https://github.com/Drew-Chase/tavern-cargo-template)
