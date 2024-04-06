_: {
  flake.nixosModules.shared-prelude = { pkgs, lib, ... }:
    let
      inherit (pkgs.stdenv) isDarwin;
      inherit (lib.attrsets) optionalAttrs;
    in {
      nix = {
        package = pkgs.nixFlakes;
        gc = {
          automatic = true;
          options = "--delete-older-than 7d";
        };
        settings = {
          experimental-features = ''
            nix-command flakes
          '';
          substituters = [
            "https://ttak0422.cachix.org"
            "https://ttak0422-vim-plugins-overlay.cachix.org"
            "https://nix-community.cachix.org"
            "https://cachix.org/api/v1/cache/emacs"
          ];
          trusted-public-keys = [
            "ttak0422.cachix.org-1:nv62UZqX8/xe5jSyyTu4Z7tSpX1TiCYaYv89Xe7CFaM="
            "ttak0422-vim-plugins-overlay.cachix.org-1:YqM0x7zLhQtcskLyiCGp810p/C7WjQ94jp9CJ7UY46E="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "emacs.cachix.org-1:b1SMJNLY/mZF6GxQE+eDBeps7WnkT0Po55TAyzwOxTY="
          ];
        } // optionalAttrs isDarwin {
          extra-platforms = "aarch64-darwin x86_64-darwin";
        };
      };
    };
}
