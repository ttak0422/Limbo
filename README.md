> [!WARNING]
> → Limbo will be archived. (refined new dotfiles → [dotfiles-nvim](https://github.com/ttak0422/dotfiles-nvim), [dotfiles](https://github.com/ttak0422/dotfiles))

<h1 align="center">
    Limbo
</h1>
<div align="center">
  <img alt="nix" src="https://img.shields.io/badge/nix-5277C3.svg?&style=for-the-badge&logo=NixOS&logoColor=white">
  <img alt="tag" src="https://img.shields.io/github/v/tag/ttak0422/Limbo?style=for-the-badge&label=latest%20tag&color=orange">
  <img alt="license" src="https://img.shields.io/github/license/ttak0422/Limbo?style=for-the-badge">
  <p>dotfiles v4</p>
</div>

## Neovim

![image](https://github.com/ttak0422/Limbo/assets/15827817/8bd61f0d-6be0-4616-9a44-ad76a1a1a6bf)

> [!NOTE]
> require skk server running on port 1178.
```shell
# just run
nix run 'github:ttak0422/Limbo#bundler-nvim'
```

```shell
# run with tag
nix run 'github:ttak0422/Limbo/2024-02-28#bundler-nvim'
```

## Vim

wip...

## Hosts

### darwin 

```shell
darwin-rebuild switch --flake .#darwin
```

### nixos (wsl)

```shell
sudo nixos-rebuild switch --flake .#wsl
```
