.DEFAULT_GOAL := help
help:
	@echo "Explicit target specification required."

.PHONY: updateVimPluginsUnstable
updateVimPluginsUnstable:
	nix flake lock --update-input vim-plugins-overlay-unstable

.PHONY: updateVimPlugins
updateVimPlugins: updateVimPluginsUnstable
	nix flake lock --update-input vim-plugins-overlay
