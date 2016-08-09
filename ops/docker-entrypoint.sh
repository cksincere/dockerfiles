#!/bin/bash

set -e

: ${PUBLIC_KEY_PATH:? "Must be set"}

for f in $(find $PUBLIC_KEY_PATH -type f); do 

  user=$(basename $f)
  useradd -m $user
  mkdir /home/$user/.ssh
  chmod 0700 /home/$user/.ssh
  cp $f /home/$user/.ssh/authorized_keys
  chmod 0600 /home/$user/.ssh/authorized_keys
  chown -R $user:$user /home/$user
done

exec $@
