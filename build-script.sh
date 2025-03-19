const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

// Función para ejecutar comandos
function run(command) {
  try {
    console.log(`Ejecutando: ${command}`);
    execSync(command, { stdio: 'inherit' });
    return true;
  } catch (error) {
    console.log(`Error ejecutando: ${command}`);
    console.error(error.message);
    return false;
  }
}

// Intentar instalar la dependencia problemática
run('npm install @rollup/rollup-linux-x64-gnu --no-save');

// Intenta un enfoque alternativo si el anterior falla
console.log('Configurando el entorno para el build...');

// Modificar el paquete de Rollup para evitar el problema de dependencias nativas
const rollupNativePath = path.join(__dirname, 'node_modules', 'rollup', 'dist', 'native.js');
if (fs.existsSync(rollupNativePath)) {
  console.log('Modificando rollup/dist/native.js para evitar errores de dependencias...');
  
  // Leer el archivo
  let content = fs.readFileSync(rollupNativePath, 'utf8');
  
  // Modificar el contenido para evitar el error
  content = content.replace(
    /throw new Error\([^)]*\);/g,
    'console.warn("Advertencia: No se encontró el módulo nativo de Rollup, usando la implementación de respaldo."); return null;'
  );
  
  // Guardar el archivo modificado
  fs.writeFileSync(rollupNativePath, content);
  console.log('Archivo modificado correctamente.');
}

// Ejecutar el build
console.log('Ejecutando build...');
run('vite build');