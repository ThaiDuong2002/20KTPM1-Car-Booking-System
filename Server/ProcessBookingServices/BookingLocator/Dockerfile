FROM node:alpine
WORKDIR /server/process-booking-services/booking-locator
COPY package*.json .
RUN npm install
# RUN npm ci --only=production
COPY . .
ENTRYPOINT ["npm", "start"]
# CMD ["npm", "start"]