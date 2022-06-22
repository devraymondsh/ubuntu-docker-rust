# syntax=docker/dockerfile:1
FROM ubuntu:focal

WORKDIR /installer
ADD ./install.sh ./install.sh
RUN chmod +x ./install.sh && ./install.sh
