FROM mariadb:10.11.3

LABEL maintainer="Dalibor Hornik"
LABEL description="Create incremental backups periodically of MariaDB"

RUN apt-get update && apt-get -y install cron curl unzip zip && rm -rf /etc/cron.* 
RUN curl https://rclone.org/install.sh | bash
#rsync openssh-client
RUN mkdir /images && chown -R www-data:www-data /images && chmod -R 777 /images
COPY scripts /scripts
RUN  chmod +x /scripts/*

VOLUME /backup /var/lib/mysql
WORKDIR /backup

ENTRYPOINT []
CMD ["/scripts/start.sh"]