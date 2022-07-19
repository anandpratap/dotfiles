PHONY: all

all: extra dotfiles ## Install dotfiles

extra:
	ln -snf $(CURDIR)/.emacs.org $(HOME)/.emacs.org
	ln -snf $(CURDIR)/.emacs $(HOME)/.emacs

	mkdir -p $(HOME)/.config/systemd/user
	ln -snf $(CURDIR)/emacs.service $(HOME)/.config/systemd/user/emacs.service
	mkdir -p $(HOME)/.emacs.d/vendor

dotfiles: ## Installs the dotfiles.
	# add aliases for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git" -not -name ".*.swp" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	ln -sfn $(CURDIR)/gitignore $(HOME)/.gitignore;
	git update-index --skip-worktree $(CURDIR)/.gitconfig;
	mkdir -p $(HOME)/.config;
	mkdir -p $(HOME)/.local/share;
	ln -snf $(CURDIR)/.fonts $(HOME)/.local/share/fonts;
	ln -snf $(CURDIR)/.bash_profile $(HOME)/.profile;
	touch $(HOME)/.bashrc_local;
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
