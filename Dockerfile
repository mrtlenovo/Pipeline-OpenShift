FROM node:16-alpine
WORKDIR /app
COPY . .
RUN chmod +x ./run-smoke-tests.sh  # Grant executable permission to the script
RUN npm install
CMD ["npm", "start"]
EXPOSE 3000
