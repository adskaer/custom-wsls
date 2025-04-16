FROM archlinux:latest

# Update
RUN pacman-key --init
RUN pacman -Syu --noconfirm

# Install software
RUN pacman -Sy --noconfirm \
	git \
	zsh \
	curl \
	less \
	mandoc \
	openssh \
	sudo \
	vim \
	tmux

# Localization Setup
RUN sed -i "s/#en_US\.UTF\-8\ UTF\-8/en_US\.UTF\-8\ UTF\-8/" /etc/locale.gen
RUN locale-gen
RUN echo 'LANG=en_US.UTF-8' > /etc/locale.conf

# Get those manpages
RUN sed -i "s/NoExtract\ \ \=\ usr\/share\/man/#NoExtract\ \=\ usr\/share\/man/" /etc/pacman.conf
RUN pacman -Fy --noconfirm
RUN pacman -S $(pacman -Qq $(pacman -Fq /usr/share/man/ | cut -d/ -f2) 2> /dev/null) --noconfirm
RUN makewhatis /usr/share/man

# Add setup scripts to /opt
ADD ./setup_scripts /opt/setup_scripts

# Add wsl files to container
ADD wsl-configuration/wsl-distribution.conf /etc/wsl-distribution.conf
ADD wsl-configuration/wsl.conf /etc/wsl.conf
ADD wsl-configuration/icon.ico /usr/lib/wsl/icon.ico
ADD wsl-configuration/oobe.sh /etc/oobe.sh

