#!/bin/bash

: ${DOCKER_GID:?"must be set"}

groupadd -r -g ${DOCKER_GID} docker
gpasswd -a jenkins docker

gosu jenkins /bin/tini -- /usr/local/bin/jenkins.sh $@
