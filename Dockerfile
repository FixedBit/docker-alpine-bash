FROM alpine:3.14

ENV BASH_ENV /etc/profile
ENV ENV /etc/profile

USER root

ADD rootfs /

RUN apk add --no-cache bash bash-completion sudo git shadow curl jq wget nano tini \
    coreutils sed less gawk util-linux build-base abuild ca-certificates \
    openssh-client mysql-client command-not-found \
    binutils make automake autoconf g++ gcc pkgconfig \
    perl fcgi fcgiwrap spawn-fcgi; \
    groupadd -r user -g 1000; \
    useradd -p $(openssl passwd -1 password) -u 1000 -m -d /user -G wheel,root -g user -s /bin/bash user; \
    sed -i 's,/bin/ash,/bin/bash,g' /etc/passwd; \
    sudo sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+NOPASSWD:\s\+ALL\)/\1/' /etc/sudoers; \
    cp -r /etc/skel/. /root; \
    chmod +x /entrypoint.sh

VOLUME ["/store"]

ENTRYPOINT ["/entrypoint.sh"]
