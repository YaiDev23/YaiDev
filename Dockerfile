# Usar nginx como servidor web para servir archivos estáticos
FROM nginx:alpine

# Crear directorio de trabajo
WORKDIR /usr/share/nginx/html

# Copiar configuración personalizada de nginx primero
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copiar archivos HTML, CSS y JS
COPY index.html .
COPY style.css .
COPY script.js .

# Copiar directorio de assets
COPY assets/ ./assets/

# Exponer el puerto 80
EXPOSE 80

# Comando por defecto para iniciar nginx
CMD ["nginx", "-g", "daemon off;"]
