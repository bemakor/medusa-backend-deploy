FROM node:18

WORKDIR /app

RUN apt-get update && apt-get install -y \
    python3 \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY package.json yarn.lock ./
RUN yarn install

COPY . .

EXPOSE 9000

CMD ["yarn", "dev"]
