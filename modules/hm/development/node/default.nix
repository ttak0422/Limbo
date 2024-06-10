{ pkgs, ... }:
{
  home =
    let
      corepack' =
        with pkgs;
        corepack.overrideAttrs {
          buildInputs = [ nodejs ];
          phases = [ "installPhase" ];
          installPhase = ''
            mkdir -p $out/bin
            corepack enable --install-directory=$out/bin
          '';
        };
    in
    {
      packages = with pkgs; [
        nodejs
        volta
      ];
      file.".npmrc".text = builtins.readFile ./.npmrc;
    };
}
