import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import laravel from 'laravel-vite-plugin'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    laravel({
      input: ['src/main.tsx'],
      refresh: true,
    }),
    react(),
  ],
  
})
