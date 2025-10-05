FROM node:20-alpine

WORKDIR /app

# Copy dependency files
COPY package*.json ./
RUN npm install

# Copy all source code
COPY . .

# Build Strapi admin panel
RUN npm run build

EXPOSE 1337
CMD ["npm", "run", "start"]
