#!/bin/sh

/usr/sbin/rsyslogd
/usr/sbin/sshd
/usr/sbin/dovecot
/usr/sbin/postfix start

exec /bin/sleep 999d
