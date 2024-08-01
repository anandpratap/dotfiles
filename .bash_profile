#!/bin/bash

# Load .bashrc and other files...
for file in ~/.{bashrc,bash_prompt,aliases,functions,path,extra,exports,bashrc_local}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file
export MODULAR_HOME="/Users/anandps/.modular"
export PATH="/Users/anandps/.modular/pkg/packages.modular.com_mojo/bin:$PATH"
