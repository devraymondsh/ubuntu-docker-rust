# syntax=docker/dockerfile:1
FROM ubuntu:kinetic

WORKDIR /installer
ADD ./install.sh ./install.sh
RUN chmod +x ./install.sh && ./install.sh
