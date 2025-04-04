FROM node:20

WORKDIR /app

COPY package.json yarn.lock ./

RUN corepack enable && corepack prepare yarn@4.8.1 --activate

RUN yarn install

COPY . .

EXPOSE 9000

CMD ["yarn", "start"]
