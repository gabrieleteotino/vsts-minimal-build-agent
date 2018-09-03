FROM alpine:3.8

RUN apk update && apk upgrade \
    && apk add --no-cache \
    bash \
    git \
    openssh \
    curl \
    && curl -sLO https://github.com/git-lfs/git-lfs/releases/download/v2.5.1/git-lfs-linux-amd64-v2.5.1.tar.gz \
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