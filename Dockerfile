# Dovecot & Postfix testbed for Geary
# Ideas taken from https://github.com/sullof/docker-sshd

FROM ubuntu:quantal
MAINTAINER Charles Lindsay <chaz@yorba.org>

RUN apt-get update -y
RUN apt-get upgrade -y

# Allow dovecot install to succeed (see
# https://github.com/dotcloud/docker/issues/1024)
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Allow postfix to install without interaction.
RUN echo "postfix postfix/mailname string example.com" | debconf-set-selections
RUN echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections

RUN apt-get install -y openssh-server
RUN apt-get install -y dovecot-imapd
RUN apt-get install -y postfix

RUN mkdir /var/run/sshd
ADD dovecot.conf /etc/dovecot/conf.d/99-test.conf
ADD postfix.cf /postfix.cf.test
RUN cat /postfix.cf.test >> /etc/postfix/main.cf && rm /postfix.cf.test

RUN groupadd test
RUN useradd -g test -m -s /bin/bash test
RUN echo "root:root" | chpasswd
RUN echo "test:test" | chpasswd

ADD init.sh /init.sh
EXPOSE 22 25 80 110 143 465 993 995

CMD ["/init.sh"]
