# Step 1: Use a newer Node.js version as the build environment
FROM node:18 as build

# Set working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application to the container
COPY . .

# Build the React application using Vite
RUN npm run build

# Step 2: Use NGINX as the server to serve the built files
FROM nginx:alpine

# Copy the built files from the previous stage to NGINX's web directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 to the host
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
