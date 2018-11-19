FROM microsoft/dotnet:2.1-sdk

ARG NUGET_MODUL_SRC

WORKDIR /src

RUN apt-get update && apt-get install -y \
    dpkg \
    gettext \
    binutils \
    && \
    apt-get clean

COPY ./scripts/ /usr/local/bin/

COPY ./debian /tmp/debian

RUN chmod u+x /usr/local/bin/modul_*.sh

ENTRYPOINT ["/usr/local/bin/modul_entrypoint.sh"]