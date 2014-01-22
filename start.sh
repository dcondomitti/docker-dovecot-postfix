#!/bin/sh

/usr/sbin/sshd
/etc/init.d/postfix start
/usr/sbin/dovecot

exec /bin/sleep 999d
