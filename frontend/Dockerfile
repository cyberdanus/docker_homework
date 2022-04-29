FROM node:15-alpine as prepair
WORKDIR /front
COPY ./ /front
RUN npm install
RUN npm run build

FROM nginx:stable-alpine
COPY --from=prepair /front/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]
