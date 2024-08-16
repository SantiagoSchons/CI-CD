# Etapa de construção
FROM node:18 AS build

# Define o diretório de trabalho
WORKDIR /app

# Copia o package.json e o package-lock.json
COPY package*.json ./

# Instala as dependências
RUN npm install

# Copia o restante do código-fonte
COPY . .

# Executa o build do Vue.js
RUN npm run build

# Etapa final
FROM nginx:alpine

# Copia os arquivos de build para o diretório do nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Expõe a porta padrão do nginx
EXPOSE 80

# Comando padrão
CMD ["nginx", "-g", "daemon off;"]
