FROM node

WORKDIR /usr/src/app

#RUN groupadd -r agents && useradd -r -g agents --no-log-init agent

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
