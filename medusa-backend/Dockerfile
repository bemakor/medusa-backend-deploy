FROM node:18

WORKDIR /app

COPY medusa-backend/package.json .  
COPY medusa-backend/yarn.lock .  
RUN yarn install  

COPY medusa-backend/ .  

EXPOSE 9000
CMD ["yarn", "start"]
