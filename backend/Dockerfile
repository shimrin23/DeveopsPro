# backend/Dockerfile
FROM node:18-alpine

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --production

# Copy all source code (server.js, .env, etc.)
COPY . .

# Expose the port defined in your server.js and docker-compose
EXPOSE 5001

# Start the server
CMD ["npm", "start"]