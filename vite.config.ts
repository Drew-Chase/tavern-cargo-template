import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
{% if backend == "php" -%}
import laravel from 'laravel-vite-plugin'
{%- endif %}

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    {% if backend == "php" -%}
    laravel({
      input: ['src/main.tsx'],
      refresh: true,
    }),
    {%- endif %}
    react(),
  ],
  {% if backend == "actix" -%}
  server: {
    port: 3000,
    strictPort: false,
    proxy: {
      '/api': {
        target: 'http://localhost:{{api_port}}',
        changeOrigin: true,
      },
    },
  },
  build: {
    outDir: 'target/wwwroot',
  },
  {%- elsif backend == "tauri" -%}
  // prevent vite from obscuring rust errors
  clearScreen: false,
  // Tauri expects a fixed port, fail if that port is not available
  server: {
    strictPort: true,
  },
  // to access the Tauri environment variables set by the CLI with information about the current target
  envPrefix: ['VITE_', 'TAURI_PLATFORM', 'TAURI_ARCH', 'TAURI_FAMILY', 'TAURI_PLATFORM_VERSION', 'TAURI_PLATFORM_TYPE', 'TAURI_DEBUG'],
  build: {
    // Tauri uses Chromium on Windows and WebKit on macOS and Linux
    target: process.env.TAURI_PLATFORM == 'windows' ? 'chrome105' : 'safari13',
    // don't minify for debug builds
    minify: !process.env.TAURI_DEBUG ? 'esbuild' : false,
    // produce sourcemaps for debug builds
    sourcemap: !!process.env.TAURI_DEBUG,
  },
  {%- elsif backend == "vanilla" -%}
  server: {
    port: 5173,
    strictPort: false,
  },
  {%- elsif backend == "nodejs" -%}
  server: {
    port: 3000,
    strictPort: false,
    proxy: {
      '/api': {
        target: 'http://localhost:{{api_port}}',
        changeOrigin: true,
      },
    },
  },
  build: {
    outDir: 'dist',
  },
  {%- endif %}
})
