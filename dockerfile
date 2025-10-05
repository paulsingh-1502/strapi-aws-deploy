# 1️⃣ Use official Node.js LTS image
FROM node:20-alpine

# 2️⃣ Set working directory
WORKDIR /usr/src/app

# 3️⃣ Copy package.json & package-lock.json first for caching
COPY package*.json ./

# 4️⃣ Install dependencies
RUN npm install --production

# 5️⃣ Copy the rest of the app
COPY . .

# 6️⃣ Build Strapi admin panel
RUN npm run build

# 7️⃣ Expose Strapi port (default 1337)
EXPOSE 1337

# 8️⃣ Set environment variable for production
ENV NODE_ENV=production

# 9️⃣ Start Strapi
CMD ["npm", "run", "start"]
