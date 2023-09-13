FROM node:alpine
WORKDIR /server/logging-services
COPY package*.json .
RUN npm install
# RUN npm ci --only=production
COPY . .
ENTRYPOINT ["npm", "start"]
# CMD ["npm", "start"]