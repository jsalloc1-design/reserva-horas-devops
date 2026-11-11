# Imagen base liviana y oficial de Nginx
FROM nginx:alpine

LABEL maintainer="Proyecto DevOps - Reserva de Horas Médicas" \
      version="1.0.0" \
      description="Sitio web estático de reserva de horas médicas servido con Nginx"

# Se eliminan los archivos por defecto y se copian los archivos estáticos del proyecto
RUN rm -rf /usr/share/nginx/html/*
COPY src/ /usr/share/nginx/html/

# Puerto interno donde escucha Nginx
EXPOSE 80

# Verificación básica de salud del servicio
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD wget -q -O /dev/null http://localhost/ || exit 1
