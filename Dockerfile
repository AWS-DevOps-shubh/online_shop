# Stage 1 Build
# Base image 
FROM node:20-alpine AS DevHack

# Working Directory 
WORKDIR /DevOpsHackthon

COPY package*.json  ./

RUN npm install

COPY . .

RUN npm run build


# Stage 2 start

FROM node:20-alpine

WORKDIR /DevOpsHackthon

RUN npm install -g serve

RUN addgroup --gid 1001 Devhackthon
RUN  adduser --uid 1002 --disabled-password --gecos "" --ingroup Devhackthon hackthon1

# Set correct ownership for /app
RUN chown -R hackthon1:Devhackthon /DevOpsHackthon

# Copy the built files from the build stage
COPY --from=DevHack /DevOpsHackthon/dist ./dist

USER hackthon1

EXPOSE 4000

CMD ["serve", "-s", "dist", "-l", "4000"]
