FROM node:20

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install

COPY . .

EXPOSE 9000

# Disable Medusa Admin UI
ENV MEDUSA_FF_DISABLE_ADMIN=true

CMD ["yarn", "start"]
