# tải node
FROM node:alpine 
# Tạo thư mục trong container
WORKDIR /server/admin-services
# Copy package file
COPY package*.json .

RUN npm install
# RUN npm ci --only=production

# Copy tất cả file ở folder hiện tại sang thư mục ở container
COPY . .
ENTRYPOINT ["npm", "start"]
# CMD ["npm", "start"]