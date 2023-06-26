## Build stage

# Global ARGS

ARG FROM_IMAGE_BUILD=zencash/sc-ci-base:focal_jdk-11_latest

ARG FROM_IMAGE_RUN=eclipse-temurin:11-jre-focal

FROM $FROM_IMAGE_BUILD as builder

MAINTAINER infrastructure@zensystem.io

# Scoped ARGS

ARG ARG_SC_COMMITTISH

ARG ARG_SC_GITHUB_REPO=https://github.com/HorizenOfficial/eon.git

ENV SC_COMMITTISH=${ARG_SC_COMMITTISH} \
    SC_GITHUB_REPO=${ARG_SC_GITHUB_REPO} \
    REPO_DEST='/EON'

SHELL ["/bin/bash", "-c"]

RUN set -euo pipefail && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends dist-upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y software-properties-common \
    && add-apt-repository -y ppa:ethereum/ethereum && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y gcc libc6-dev solc \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends git \
    && git clone ${SC_GITHUB_REPO} ${REPO_DEST} && cd ${REPO_DEST} \
    && git checkout ${SC_COMMITTISH} && mvn install -DskipTests

## EVMAPP stage

FROM ${FROM_IMAGE_RUN} AS evmapp

MAINTAINER infrastructure@zensystem.io

# Scoped ARGS

ARG ARG_SC_VERSION

ARG ARG_SC_JAR_NAME=eon

ARG ARG_SC_MAIN_CLASS=io.horizen.eon.EonApp

ARG ARG_SC_CONF_PATH=/sidechain/config/sc_settings.conf

ARG ARG_GOSU_VERSION=1.14

ARG ARG_TINI_VERSION=v0.19.0

ENV SC_VERSION=${ARG_SC_VERSION} \
    SC_JAR_NAME=${ARG_SC_JAR_NAME} \
    SC_MAIN_CLASS=${ARG_SC_MAIN_CLASS} \
    SC_CONF_PATH=${ARG_SC_CONF_PATH} \
    GOSU_VERSION=${ARG_GOSU_VERSION} \
    TINI_VERSION=${ARG_TINI_VERSION} \
    REPO_DEST='/EON'

WORKDIR /sidechain

SHELL ["/bin/bash", "-c"]

COPY --from=builder ${REPO_DEST}/node/target/*.jar /sidechain/

COPY --from=builder ${REPO_DEST}/node/target/lib /sidechain/lib

COPY ./dockerfiles/evmapp/entrypoint.sh ./dockerfiles/evmapp/sc_settings.conf.tmpl /sidechain/

RUN set -eEuo pipefail && mv /sidechain/entrypoint.sh /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint.sh && mkdir -p /sidechain/config/ \
    && mv /sidechain/sc_settings.conf.tmpl /sidechain/config && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install apt-utils \
    && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends dist-upgrade \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates \
      curl \
      dnsutils \
      gettext-base \
      libjemalloc2 \
      jq \
      netcat-openbsd \
      apache2-utils \
    && savedAptMark="$(apt-mark showmanual)" \
    && if ! command -v gosu &> /dev/null; then \
      if ! command -v gpg2 &> /dev/null; then \
        DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends gnupg2 dirmngr; \
      fi \
      && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
      && curl -sSfL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" > /usr/local/bin/gosu \
      && curl -sSfL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" > /usr/local/bin/gosu.asc \
      && export GNUPGHOME="$(mktemp -d)" \
      && ( gpg2 --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 || \
       gpg2 --batch --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 || \
       gpg2 --batch --keyserver pgp.mit.edu --recv-key B42F6819007F00F88E364FD4036A9C25BF357DD4 ) \
      && gpg2 --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
      && ( gpgconf --kill dirmngr || true ) \
      && ( gpgconf --kill gpg-agent || true ) \
      && rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
      && unset GNUPGHOME \
      && chmod +x /usr/local/bin/gosu \
      && gosu --version; \
    fi \
    && if ! command -v tini &> /dev/null; then \
      if ! command -v gpg2 &> /dev/null; then \
        DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends gnupg2 dirmngr; \
      fi \
      && curl -sSfL "https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini" > /usr/local/bin/tini \
      && curl -sSfL "https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc" > /usr/local/bin/tini.asc \
      && export GNUPGHOME="$(mktemp -d)" \
      && ( gpg2 --batch --keyserver hkps://keys.openpgp.org --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 || \
       gpg2 --batch --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 || \
       gpg2 --batch --keyserver pgp.mit.edu --recv-key 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 ) \
      && gpg2 --batch --verify /usr/local/bin/tini.asc /usr/local/bin/tini \
      && ( gpgconf --kill dirmngr || true ) \
      && ( gpgconf --kill gpg-agent || true ) \
      && rm -rf "$GNUPGHOME" /usr/local/bin/tini.asc \
      && unset GNUPGHOME \
      && chmod +x /usr/local/bin/tini \
      && tini --version; \
    fi \
    && apt-mark auto '.*' &> /dev/null && [ -z "$savedAptMark" ] || apt-mark manual $savedAptMark &> /dev/null \
    && DEBIAN_FRONTEND=noninteractive apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/{lib/apt/lists/*,cache/apt/archives/*.deb} /tmp/*

VOLUME ["/sidechain/datadir/"]

VOLUME ["/sidechain/logs/"]

ENTRYPOINT ["/usr/local/bin/tini", "--", "/usr/local/bin/entrypoint.sh"]

# This is a placeholder CMD, the actual CMD is constructed in entrypoint.sh based on ENV vars like this:
# "java -cp '/sidechain/${ARG_SC_JAR_NAME}-${SC_VERSION}.jar:/sidechain/lib/*' $SC_MAIN_CLASS $SC_CONF_PATH"
CMD ["/usr/bin/true"]