import { defineConfig } from 'vite';
import reactSWC from '@vitejs/plugin-react-swc';

export default defineConfig({
  plugins: [reactSWC()],
  // Resto de tu configuración
});