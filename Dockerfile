# Étape 1 : Construire l'application Angular
FROM node:18 as builder

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste des fichiers du projet
COPY . .

# Construire l'application Angular (notez la correction de la commande)
RUN npm run build --configuration production

# Étape 2 : Configurer un serveur pour servir l'application
FROM nginx:alpine

# Copier les fichiers construits depuis l'étape précédente
COPY --from=builder /app/dist/sunu-pointage-front /usr/share/nginx/html

# Copier un fichier de configuration Nginx personnalisé (facultatif)
# COPY nginx.conf /etc/nginx/nginx.conf

# Exposer le port sur lequel Nginx servira l'application
EXPOSE 80

# Commande de démarrage pour Nginx
CMD ["nginx", "-g", "daemon off;"]
