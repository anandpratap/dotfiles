.PHONY: all

all: dotfiles ## Install dotfiles

dotfiles: ## Installs the dotfiles.
	# add aliases for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git" -not -name ".*.swp" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	gpg --list-keys || true;
	ln -sfn $(CURDIR)/.gnupg/gpg.conf $(HOME)/.gnupg/gpg.conf;
	ln -sfn $(CURDIR)/.gnupg/gpg-agent.conf $(HOME)/.gnupg/gpg-agent.conf;
	ln -sfn $(CURDIR)/gitignore $(HOME)/.gitignore;
	git update-index --skip-worktree $(CURDIR)/.gitconfig;
	mkdir -p $(HOME)/.config;
	mkdir -p $(HOME)/.local/share;
	ln -snf $(CURDIR)/.fonts $(HOME)/.local/share/fonts;
	ln -snf $(CURDIR)/.bash_profile $(HOME)/.profile;
	touch $(HOME)/.bashrc_local;

	ln -snf $(CURDIR)/.emacs.org $(HOME)/.emacs.org
	ln -snf $(CURDIR)/.emacs $(HOME)/.emacs
	ln -snf $(CURDIR)/.logins.el.gpg $(HOME)/.logins.el.gpg
	mkdir -p $(HOME)/.config/systemd/user
	ln -snf $(CURDIR)/emacs.service $(HOME)/.config/systemd/user/emacs.service
	mkdir -p $(HOME)/.emacs.d/vendor
	wget https://raw.githubusercontent.com/hayamiz/twittering-mode/master/twittering-mode.el -O $(HOME)/.emacs.d/vendor/twittering-mode.el
	wget https://raw.githubusercontent.com/hniksic/emacs-htmlize/master/htmlize.el -O $(HOME)/.emacs.d/vendor/htmlize.el
	wget http://elpa.gnu.org/packages/oauth2-0.11.el -O $(HOME)/.emacs.d/vendor/oauth2.el

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
