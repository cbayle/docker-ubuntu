# Build a simple docker image using debootstrap
docker-ubuntu1404: depends scratch
	sudo /usr/share/docker.io/contrib/mkimage.sh -t ubuntu:14.04 debootstrap --include=ubuntu-minimal --components=main,universe trusty http://archive.ubuntu.com/ubuntu

# docker seems to require a scratch image, so not pull from internet, I import it in the local repository
# See http://docs.docker.com/articles/baseimages/
scratch: depends
	tar cv --files-from /dev/null | docker import - scratch

depends: /usr/sbin/debootstrap /usr/bin/strings /usr/bin/docker

/usr/bin/docker:
	sudo apt-get install docker.io

/usr/bin/strings:
	sudo apt-get install binutils

/usr/sbin/debootstrap:
	sudo apt-get install debootstrap

run8:
	docker run --rm=true -t -i ubuntu:14.04 /bin/bash
