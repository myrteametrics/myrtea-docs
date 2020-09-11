FROM python:3.6-alpine

COPY . .

RUN apk add make
RUN make install
RUN make build