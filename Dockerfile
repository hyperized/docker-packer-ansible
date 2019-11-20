FROM hyperized/scratch:latest as trigger
# Used to trigger Docker hubs auto build, which it wont do on the official images

FROM ubuntu:bionic as packer

ARG packer_version=1.4.5

RUN apt-get update && \
    apt-get install -qq -y wget unzip && \
    wget -q https://releases.hashicorp.com/packer/${packer_version}/packer_${packer_version}_linux_amd64.zip && \
    unzip packer_${packer_version}_linux_amd64.zip && \
    cp packer /usr/local/bin/

FROM ubuntu:bionic

LABEL maintainer="Gerben Geijteman <gerben@hyperized.net>"
LABEL description="A multistage Ubuntu bionic image with Packer and Ansible"

COPY --from=packer /usr/local/bin/packer /usr/local/bin/packer

RUN apt-get update && \
    apt-get install -qq -y python3-pip openssh-client && \
    pip3 install ansible
