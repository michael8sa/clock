# Makefile for personal FreeBSD ARM Apple Silicon configuration

# Default target
all: setup

# Update the system and install essential packages
packages:
	pkg update && pkg upgrade -y
	pkg install -y git vim tmux htop zsh

# Clone or update dotfiles
dotfiles:
	if [ ! -d "$$HOME/dotfiles" ]; then \
		git clone https://github.com/yourusername/dotfiles.git $$HOME/dotfiles; \
	else \
		cd $$HOME/dotfiles && git pull; \
	fi
	# Link configuration files
	ln -sf $$HOME/dotfiles/.zshrc $$HOME/.zshrc
	ln -sf $$HOME/dotfiles/.vimrc $$HOME/.vimrc
	ln -sf $$HOME/dotfiles/.tmux.conf $$HOME/.tmux.conf

# System tweaks (example: enable services)
system:
	sysrc sshd_enable="YES"
	sysrc moused_enable="YES"

# Setup everything
setup: packages dotfiles system
	@echo "FreeBSD ARM desktop setup complete!"

# Clean (optional)
clean:
	@echo "Nothing to clean yet"

.PHONY: all packages dotfiles system setup clean
