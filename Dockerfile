FROM alpine:3.19
ENV LANG=zh_CN.UTF-8 \
    TZ=Asia/Shanghai \
    PS1="\u@\h:\w \$ "
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add --update --no-cache \
       nginx \
       nginx-mod-stream \
       nginx-mod-http-headers-more \
       nginx-mod-http-lua \
       nginx-mod-http-brotli \
       openjdk8-jre \
       net-tools \
       curl \
       wget \
       ttf-dejavu \
       fontconfig \
       tzdata \
       logrotate \
       tini \
       acme.sh \
       keepalived \
       openrc \
       procps \
    && fc-cache -f -v \
    && mkdir /run/openrc/ \
    && touch /run/openrc/softlevel \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && rm -rf /var/cache/apk/* /tmp/* \
    && wget -O /home/nginxWebUI.jar http://file.nginxwebui.cn/nginxWebUI-4.0.2.jar
COPY keepalived.conf /etc/keepalived/keepalived.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN ["chmod", "+x", "/usr/local/bin/entrypoint.sh"]
VOLUME ["/home/nginxWebUI"]
VOLUME ["/etc/keepalived"]
ENTRYPOINT ["tini", "entrypoint.sh"]
