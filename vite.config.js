import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react({
      // Desactivar SWC y usar Babel en entornos CI como Netlify
      jsxRuntime: 'classic',
      // Forzar esbuild en lugar de SWC
      babel: {
        plugins: []
      }
    })
  ],
  // Optimizaciones para entornos CI
  build: {
    // Usar esbuild para minificar
    minify: 'esbuild',
    // Evitar optimizaciones que puedan causar problemas
    cssMinify: 'esbuild',
    // No generar sourcemaps en producción
    sourcemap: false,
    // Reducir tamaño de chunks
    chunkSizeWarningLimit: 1000
  },
  // Asegurar que las rutas relativas funcionen correctamente
  base: '/',
  // Configuración específica para Netlify
  server: {
    port: 3000,
    strictPort: true
  }
})