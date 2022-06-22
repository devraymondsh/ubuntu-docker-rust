# syntax=docker/dockerfile:1
FROM ubuntu:jammy

WORKDIR /installer
ADD ./install.sh ./install.sh
RUN chmod +x ./install.sh && ./install.sh
