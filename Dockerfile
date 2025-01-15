# Etapa 1: Construir a aplicação React
FROM node:16 AS build

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Copiar os arquivos do projeto para o container
COPY package*.json ./

# Instalar as dependências
RUN npm install

# Copiar o restante dos arquivos da aplicação
COPY . .

# Construir a aplicação para produção
RUN npm run build

# Etapa 2: Servir a aplicação com Nginx
FROM nginx:alpine

# Copiar os arquivos de build do React para o diretório do Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Expor a porta 3000 para acessar a aplicação
EXPOSE 3000

# Iniciar o Nginx (não é necessário definir um CMD, pois o Nginx inicia por padrão)
CMD ["nginx", "-g", "daemon off;"]