# ---------- Build stage ----------

FROM node:18-alpine AS build
 
# Set working directory

WORKDIR /app
 
# Copy package files

COPY package.json package-lock.json* ./
 
# Install dependencies

RUN npm install
 
# Copy source code

COPY . .
 
# Build the React app

RUN npm run build
 
# ---------- Production stage ----------

FROM nginx:alpine
 
# Remove default nginx website

RUN rm -rf /usr/share/nginx/html/*
 
# Copy build output to nginx html directory

COPY --from=build /app/build /usr/share/nginx/html
 
# Expose port 80

EXPOSE 80
 
# Start nginx

CMD ["nginx", "-g", "daemon off;"]

 