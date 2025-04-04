FROM node:20

WORKDIR /app

RUN corepack enable && corepack prepare yarn@4.8.1 --activate

COPY package.json yarn.lock ./

RUN yarn install

COPY . .

EXPOSE 9000

# Disable Medusa Admin UI
ENV MEDUSA_FF_DISABLE_ADMIN=true

CMD ["yarn", "start"]
