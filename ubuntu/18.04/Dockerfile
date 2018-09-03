FROM ubuntu:18.04

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes


# Moved some basic tools in the base image from the microsoft "standard"

RUN \
 apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
 && apt-add-repository ppa:git-core/ppa \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    curl \
    dnsutils \
    netcat \
    file \
    ftp \
    git \
    iproute2 \
    iputils-ping \
    jq \
    locales \
    openssh-client \
    rsync\
    shellcheck \
    sudo \
    telnet \
    time \
    unzip \
    wget \
    zip \
    tzdata \
 && rm -rf /var/lib/apt/lists/*

# Download and install git-lfs (installing from packagecloud did not work well for me)
RUN curl -sLO https://github.com/git-lfs/git-lfs/releases/download/v2.5.1/git-lfs-linux-amd64-v2.5.1.tar.gz \
    && mkdir git-lfs && tar zxvf git-lfs-linux-amd64-v2.5.1.tar.gz -C git-lfs \
    && mv git-lfs/git-lfs /usr/bin/ \
    && rm -rf git-lfs \
    && rm -rf git-lfs-linux-amd64-v2.5.1.tar.gz

# Accept the TEE EULA
RUN mkdir -p "/root/.microsoft/Team Foundation/4.0/Configuration/TEE-Mementos" \
 && cd "/root/.microsoft/Team Foundation/4.0/Configuration/TEE-Mementos" \
 && echo '<ProductIdData><eula-14.0 value="true"/></ProductIdData>' > "com.microsoft.tfs.client.productid.xml"

WORKDIR /vsts

COPY ./start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]