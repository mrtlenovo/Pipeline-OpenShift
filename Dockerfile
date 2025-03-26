FROM node:16-alpine
WORKDIR /app
COPY run-smoke-tests.sh /app/run-smoke-tests.sh
RUN chmod +x run-smoke-tests.sh
RUN npm install
CMD ["npm", "start"]
EXPOSE 3000
