#!/bin/bash

set -e

: ${PUBLIC_KEY_PATH:? "Must be set"}
: ${PUBLIC_KEY_GPG:? "Must be set"}

if [ ! -d /tmp/oh-my-zsh ]; then
  git clone git://github.com/robbyrussell/oh-my-zsh.git /usr/local/src/oh-my-zsh
fi

if [ ! -d /usr/local/src/ansible ]; then
  git clone --recursive git://github.com/ansible/ansible.git /usr/local/src/ansible
  cd /usr/local/src/ansible
  git checkout 5f12731
  cd /root
fi

for f in $(find $PUBLIC_KEY_PATH -type f); do 

  user=$(basename $f)

  if [ ! -d /home/$user ]; then
    useradd -m $user -s /bin/zsh

    mkdir /home/$user/.ssh
    chmod 0700 /home/$user/.ssh
    cp $f /home/$user/.ssh/authorized_keys
    chmod 0600 /home/$user/.ssh/authorized_keys

    cp -R /usr/local/src/oh-my-zsh /home/$user/.oh-my-zsh
    cp /home/$user/.oh-my-zsh/templates/zshrc.zsh-template /home/$user/.zshrc

    cp -R /usr/local/src/ansible /home/$user/ansible

    echo "source /home/$user/ansible/hacking/env-setup" >> /home/$user/.zshrc
    echo "rm /home/$user/.gnupg/S.gpg-agent" > /home/$user/.zlogout

    chown -R $user:$user /home/$user
    gpasswd -a $user sudo

    sudo -H -u $user gpg2 --import $PUBLIC_KEY_GPG
  fi

done

exec $@
