FROM gabrieleteotino/vsts-minimal-agent:alpine-3.8-

# TODO verify missing pieces

# Setup the locale
ENV LANG en_US.UTF-8
ENV LC_ALL $LANG
RUN locale-gen $LANG \
 && update-locale

# Accept EULA - needed for certain Microsoft packages like SQL Server Client Tools
ENV ACCEPT_EULA=Y

# Install essential build tools
# RUN apk add --update alpine-sdk
RUN apk add build-base