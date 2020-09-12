FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY site /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
