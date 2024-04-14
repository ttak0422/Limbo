{ inputs, ... }: {
  flake.nixosModules.nixos-service = { pkgs, ... }:
    let
      inherit (inputs.yaskkserv2-service.packages.${pkgs.stdenv.hostPlatform.system})
        yaskkserv2;
      dictionary = pkgs.stdenv.mkDerivation {
        name = "yaskkserv2-dictionary";
        src = inputs.skk-dev-dict;
        # ignore Makefile
        dontBuild = true;
        installPhase = ''
          mkdir $out
          ${yaskkserv2}/bin/yaskkserv2_make_dictionary --dictionary-filename=$out/dictionary.yaskkserv2 SKK-JISYO.L
        '';
        buildInputs = [ ];
      };
    in {
      imports = [ inputs.yaskkserv2-service.nixosModules.default ];
      services.yaskkserv2 = {
        enable = true;
        dictionary = "${dictionary}/dictionary.yaskkserv2";
        googleSuggest = true;
      };
    };
}
