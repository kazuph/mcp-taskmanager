# syntax=docker/dockerfile:1

# Use official Node.js LTS image as base
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install pnpm globally
RUN npm install -g pnpm

# Copy package and lock files
COPY package.json pnpm-lock.yaml ./

RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm run build || true

# Expose port (customize if your server listens on a specific port)
EXPOSE 8080

# Start the MCP server (customize if your entrypoint is different)
CMD ["pnpm", "start"]
