#!/usr/bin/env bash

if ! whoami &>/dev/null; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-default}:x:$(id -u):0:${USER_NAME:-default} user:${HOME}:/sbin/nologin" >>/etc/passwd
  fi
fi

/usr/bin/supervisord --configuration /etc/supervisord.conf &

# wait 10sec for x11vnc
for ((i = 1; i <= 20; i++)); do
  if pgrep -x "x11vnc" &>/dev/null; then
    break
  else
    sleep 0.5s
  fi
done