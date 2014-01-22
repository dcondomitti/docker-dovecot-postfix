#!/bin/sh

/usr/sbin/sshd
/usr/sbin/dovecot
/etc/init.d/postfix start

exec /bin/sleep 999d
