#FROM python:3.4-wheezy
FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install libc6-dev
RUN apt-get -y install curl

# RUN adduser localuser
ADD root /root/
ADD repo /repo/
RUN ln -s /repo /root/repo
RUN mkdir -p /root/local/bin
RUN curl -o /root/local/bin/dcos https://downloads.dcos.io/binaries/cli/linux/x86-64/dcos-1.9/dcos
RUN chmod 755 /root/local/bin/dcos
ENV PATH=$PATH:/root/local/bin
ENTRYPOINT /root/local/bin/dlogin
#ENTRYPOINT /bin/bash
