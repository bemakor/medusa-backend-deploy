# --- Build stage ---
    FROM node:20-alpine as builder

    WORKDIR /app
    
    RUN apk add --no-cache python3 make g++
    
    COPY package.json yarn.lock ./
    RUN yarn install
    
    COPY . .
    RUN yarn build
    RUN cp -r .medusa/server/public ./public
    
    # --- Final image ---
    FROM node:20-alpine
    
    WORKDIR /app
    
    COPY --from=builder /app ./
    COPY entrypoint.sh /app/entrypoint.sh
    
    RUN chmod +x /app/entrypoint.sh
    
    EXPOSE 9000
    
    CMD ["sh", "/app/entrypoint.sh"]
    