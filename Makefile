.DEFAULT_GOAL := help
help:
	@echo "Explicit target specification required."

.PHONY: updateVimPluginsUnstable
updateVimPluginsUnstable:
	nix flake lock --update-input vim-plugins-overlay-unstable

.PHONY: updateVimPlugins
updateVimPlugins: updateVimPluginsUnstable
	nix flake lock --update-input vim-plugins-overlay

.PHONY: updateNeovimNightlyLatest
updateNeovimNightlyLatest:
	nix flake lock --update-input neovim-nightly-overlay-latest

.PHONY: updateNeovimNightly
updateNeovimNightly: updateNeovimNightlyLatest
	nix flake lock --update-input neovim-nightly-overlay
