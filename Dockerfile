# STEP: 1 - BUILD
FROM node:20-alpine as builder

WORKDIR /app
    
RUN apk add --no-cache python3 make g++
    
COPY package.json yarn.lock ./

RUN yarn install
    
COPY . .

RUN yarn build

RUN cp -r .medusa/server/public ./public

# STEP: 2 - PRODUCTION IMAGE
FROM node:20-alpine
    
WORKDIR /app
    
COPY --from=builder /app ./

COPY entrypoint.sh /app/entrypoint.sh
    
RUN chmod +x /app/entrypoint.sh
    
EXPOSE 9000
    
CMD ["sh", "/app/entrypoint.sh"]
    