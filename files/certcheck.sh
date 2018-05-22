#!/bin/bash
set -euo pipefail

for NAME in $(find /etc/nginx/ssl -name "*crt" -exec basename {} \;) ; do

  NAME=${NAME/.crt/}

  if ! openssl x509 -noout -modulus -in /etc/nginx/ssl/$NAME.crt | openssl md5 &>-; then
    echo "** The certificate $NAME probably isn't a certificate."
    exit 1
  fi

  if ! openssl rsa -noout -modulus -in /etc/nginx/ssl/$NAME.key | openssl md5 &>-; then
    echo "** The key $NAME probably isn't a key."
    exit 1
  fi

  if ! (openssl x509 -noout -modulus -in /etc/nginx/ssl/$NAME.crt | openssl md5 ; openssl rsa -noout -modulus -in /etc/nginx/ssl/$NAME.key | openssl md5) | uniq &>/dev/null; then
    echo "** The cert/keypair $NAME does not match, that's what it had to say."
    exit 1
  fi

done
