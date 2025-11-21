# Stage 1: Build the React Application
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
# Install dependencies (including dev dependencies needed for build)
RUN npm install
COPY . .
# Create the production build
RUN npm run build

# Stage 2: Serve the Application (The Production Image)
FROM node:20-alpine
WORKDIR /app

# Install only the lightweight web server
RUN npm install -g serve

# COPY ONLY the build folder from the 'builder' stage
# This discards node_modules and source code, keeping the image tiny
COPY --from=builder /app/build ./build

EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]