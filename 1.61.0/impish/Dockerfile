# syntax=docker/dockerfile:1
FROM ubuntu:impish

WORKDIR /installer
ADD ./install.sh ./install.sh
RUN chmod +x ./install.sh && ./install.sh
