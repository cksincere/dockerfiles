#!/bin/bash

set -e

: ${PUBLIC_KEY_PATH:? "Must be set"}

git clone git://github.com/robbyrussell/oh-my-zsh.git /tmp/oh-my-zsh

for f in $(find $PUBLIC_KEY_PATH -type f); do 

  user=$(basename $f)
  useradd -m $user -s /bin/zsh

  mkdir /home/$user/.ssh
  chmod 0700 /home/$user/.ssh
  cp $f /home/$user/.ssh/authorized_keys
  chmod 0600 /home/$user/.ssh/authorized_keys

  cp -R /tmp/oh-my-zsh /home/$user/.oh-my-zsh
  cp /home/$user/.oh-my-zsh/templates/zshrc.zsh-template /home/$user/.zshrc

  chown -R $user:$user /home/$user
  gpasswd -a $user sudo
done

exec $@
