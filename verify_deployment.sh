#!/bin/bash

# Script de verificación para deployment en Railway
# Este script verifica que todos los archivos necesarios estén presentes

echo "🔍 Verificando estructura del proyecto..."

# Verificar archivos principales
files=("index.html" "style.css" "script.js" "Dockerfile" "nginx.conf")
for file in "${files[@]}"; do
    if [[ -f "$file" ]]; then
        echo "✅ $file - OK"
    else
        echo "❌ $file - FALTA"
        exit 1
    fi
done

# Verificar directorio assets
if [[ -d "assets" ]]; then
    echo "✅ assets/ - OK"
    
    # Verificar subdirectorios críticos
    if [[ -d "assets/images" ]]; then
        echo "✅ assets/images/ - OK"
        echo "📊 Imágenes encontradas: $(find assets/images -type f | wc -l)"
    else
        echo "❌ assets/images/ - FALTA"
        exit 1
    fi
    
    if [[ -d "assets/fonts" ]]; then
        echo "✅ assets/fonts/ - OK"
    else
        echo "⚠️ assets/fonts/ - NO ENCONTRADO (opcional)"
    fi
else
    echo "❌ assets/ - FALTA"
    exit 1
fi

# Verificar configuración de nginx
echo "🔧 Verificando configuración nginx..."
if nginx -t -c nginx.conf 2>/dev/null; then
    echo "✅ nginx.conf - Sintaxis válida"
else
    echo "❌ nginx.conf - Error de sintaxis"
    exit 1
fi

echo ""
echo "🎉 ¡Proyecto listo para deployment en Railway!"
echo ""
echo "📝 Pasos para desplegar:"
echo "1. git add ."
echo "2. git commit -m 'Deploy optimized portfolio'"
echo "3. git push origin main"
echo "4. Conectar repositorio en Railway"
echo "5. Railway detectará el Dockerfile automáticamente"
