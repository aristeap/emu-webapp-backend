#What is Docker???->
#"To ensure your application runs the same way on any server, you should package it into a Docker image. A Docker image contains your code, all its dependencies (like Node.js), 
#and a basic operating system, making it portable and easy to deploy"
#the Docker container is a Linux invironment 


# Use an official Node.js runtime as the base image
FROM node:18-alpine

# Set the working directory in the container. This doesnt have to do with my project's app folder inside the src.It's a brand new, empty folder that Docker creates inside the container.
# my local folder structure:
#my-project/
#├── server.js
#├── package.json
#└── src/
#    └── app/
#        └── ...

#becomes this inside the container:
#/app/
#├── server.js
#├── package.json
#└── src/
#    └── app/
#        └── ...    
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
# We do this first to leverage Docker's layer caching
COPY package*.json ./

# Install the application's dependencies (with legacy peers so we dont have dependencies-conflicts issues)
RUN npm install --legacy-peer-deps

# Copy the rest of the application source code to the container
COPY . .

# Expose the port the app runs on (your server.js uses 3019)
EXPOSE 3019

# The command to run the application
# This is what will be executed when the container starts
CMD [ "node", "server.js" ]