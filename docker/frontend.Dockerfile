# Étape 1 : build du frontend
FROM node:18 AS build

WORKDIR /app

# Copier package.json et installer dépendances
COPY frontend/erp-sneat/package*.json ./
RUN npm install

# Copier tout le code frontend
COPY frontend/erp-sneat/ .

# Build pour la production
RUN npm run build

# Étape 2 : serveur Nginx pour servir les fichiers buildés
FROM nginx:1.25

# Copier le build React/Next.js vers le dossier Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Copier la config Nginx personnalisée
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
