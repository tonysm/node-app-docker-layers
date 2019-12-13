FROM node:13.3.0

WORKDIR /app

RUN apt-get update && apt-get install -y git

COPY package.json package-lock.json /app/

RUN npm ci

COPY . /app

EXPOSE 3000

CMD ["npm", "run", "serve"]
