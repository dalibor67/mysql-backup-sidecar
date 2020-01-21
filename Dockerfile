FROM debian:10-slim

LABEL maintainer="Wolfgang Gassler"
LABEL description="XtraBackup based MySQL / MariaDB backup docker image to create incremental backups periodically"

# installing xtrabackup according to https://www.percona.com/doc/percona-xtrabackup/8.0/installation/apt_repo.html

RUN . /etc/os-release \
    && apt-get update \
    && apt-get -y install wget lsb-release gnupg cron \
    && rm -rf /etc/cron.* \
    && . /etc/os-release \
    && wget https://repo.percona.com/apt/percona-release_latest.${VERSION_CODENAME}_all.deb \
    && dpkg -i percona-release_latest.${VERSION_CODENAME}_all.deb \
    && rm -f percona-release_latest.${VERSION_CODENAME}_all.deb \
    && percona-release enable-only tools release \
    && apt-get update \
    && apt-get -y install percona-xtrabackup-80

COPY scripts /scripts

VOLUME /backup /var/lib/mysql
WORKDIR /backup

CMD ["/scripts/start.sh"]