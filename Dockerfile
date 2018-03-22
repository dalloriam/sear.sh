FROM jess/zsh

ADD "sear.sh" "service.sh" "/"

ARG AG_VERSION=2.0.0
ENV GIT_REPO https://github.com/ggreer/the_silver_searcher.git
ENV BUILD_TOOLS "git automake autoconf make g++"

RUN apk --update add ${BUILD_TOOLS} pcre-dev xz-dev

RUN git clone --depth 1 --single-branch --branch ${AG_VERSION} ${GIT_REPO}

WORKDIR ./the_silver_searcher
RUN ./build.sh && cp ./ag /bin

# Cleaning
RUN apk del ${BUILD_TOOLS}
RUN mkdir /data && rm -fr /var/apk/caches

EXPOSE 1500

WORKDIR /
ENTRYPOINT ["/bin/zsh", "/sear.sh"]
