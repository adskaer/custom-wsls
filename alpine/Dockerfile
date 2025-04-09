FROM alpine:latest

# Update alpine
RUN apk update && apk upgrade

# Install software
RUN apk add --no-cache \
	python3 \
	git \
	zsh \
	curl \
	openssh \
	sudo \
	vim \
	shadow \
	tmux

# Add setup scripts to /opt
ADD ./setup_scripts /opt/setup_scripts

# Add wsl files to container
ADD wsl-configuration/wsl-distribution.conf /etc/wsl-distribution.conf
ADD wsl-configuration/wsl.conf /etc/wsl.conf
ADD wsl-configuration/alpine.ico /usr/lib/wsl/icon.ico
ADD wsl-configuration/oobe.sh /etc/oobe.sh

