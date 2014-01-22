# Dovecot & Postfix testbed for Geary
# Ideas taken from https://github.com/sullof/docker-sshd

FROM ubuntu
MAINTAINER Charles Lindsay <chaz@yorba.org>

RUN apt-get update && apt-get upgrade

RUN echo "postfix postfix/mailname string example.com" | debconf-set-selections
RUN echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
RUN apt-get install -y postfix dovecot-imapd openssh-server

RUN mkdir /var/run/sshd

RUN groupadd test
RUN useradd -g test -m -s /bin/bash test
RUN echo "root:root" | chpasswd
RUN echo "test:test" | chpasswd

ADD postfix.cf /postfix.cf.test
RUN cat /postfix.cf.test >> /etc/postfix/main.cf
RUN rm /postfix.cf.test
ADD dovecot.conf /etc/dovecot/conf.d/99-test.conf
ADD start.sh /start.sh

CMD ["/start.sh"]
