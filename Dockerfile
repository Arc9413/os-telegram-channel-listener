FROM node:14-alpine AS development

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install glob rimraf
RUN npm install --only=development

COPY . .

RUN npm run build



FROM node:14-alpine AS production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --only=production

COPY . .

COPY --from=development /usr/src/app/dist ./dist

CMD ["node", "dist/main"]