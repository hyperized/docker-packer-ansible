FROM ubuntu:bionic as packer

RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://releases.hashicorp.com/packer/1.3.5/packer_1.3.5_linux_amd64.zip && \
    unzip packer_1.3.5_linux_amd64.zip && \
    cp packer /usr/local/bin/

FROM ubuntu:bionic

LABEL maintainer="Gerben Geijteman <gerben@hyperized.net>"
LABEL description="A multistage Ubuntu bionic image with Packer and Ansible"

COPY --from=packer /usr/local/bin/packer /usr/local/bin/packer

RUN apt-get update && \
    apt-get install -qq -y python3-pip && \
    pip3 install ansible
