FROM node:alpine
WORKDIR /server/customer-services
COPY package*.json .
RUN npm install
# RUN npm ci --only=production
COPY . .
ENTRYPOINT ["npm", "start"]
# CMD ["npm", "start"]