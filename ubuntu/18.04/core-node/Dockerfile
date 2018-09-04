FROM gabrieleteotino/vsts-minimal-agent:ubuntu-18.04

# To make it easier for build and release pipelines to run apt-get,
# configure apt to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# Install packagecloud key
# RUN curl -L "https://packagecloud.io/github/git-lfs/gpgkey" 2> /dev/null | apt-key add - &>/dev/null
# RUN apt-key adv --fetch-keys https://packagecloud.io/github/git-lfs/gpgkey

# Setup the locale
ENV LANG en_US.UTF-8
ENV LC_ALL $LANG
RUN apt-get update \
 && apt-get install -y --no-install-recommends \ 
    locales \
 && locale-gen $LANG \
 && update-locale

# Accept EULA - needed for certain Microsoft packages like SQL Server Client Tools
ENV ACCEPT_EULA=Y

# Install essential build tools
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    build-essential \
 && rm -rf /var/lib/apt/lists/*

# Install .NET Core SDK and initialize package cache
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb > packages-microsoft-prod.deb \
 && dpkg -i packages-microsoft-prod.deb \
 && rm packages-microsoft-prod.deb \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    apt-transport-https \
    dotnet-sdk-2.1 \
 && rm -rf /var/lib/apt/lists/*
RUN dotnet help
ENV dotnet=/usr/bin/dotnet

# Install LTS Node.js and related tools
RUN curl -sL https://git.io/n-install | bash -s -- -ny - \
 && ~/n/bin/n lts \
 && npm install -g bower \
 && npm install -g grunt \
 && npm install -g gulp \
 && npm install -g n \
 && npm install -g webpack webpack-cli --save-dev \
 && npm install -g parcel-bundler \
 && npm i -g npm \
 && rm -rf ~/n
ENV bower=/usr/local/bin/bower \
    grunt=/usr/local/bin/grunt

# Download and install vsts Agent
#RUN curl https://vstsagentpackage.azureedge.net/agent/2.139.1/vsts-agent-linux-x64-2.139.1.tar.gz > vsts-agent.tar.gz \
# && mkdir vsts-agent \
# && tar zxvf vsts-agent.tar.gz -C vsts-agent

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    libunwind8 \
    libicu60 \
 && rm -rf /var/lib/apt/lists/*
