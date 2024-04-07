{ pkgs, ... }: {
  home = {
    packages = (with pkgs; [ nodejs ])
      ++ (with pkgs.nodePackages; [ npm yarn pnpm ]);
    file.".npmrc".text = builtins.readFile ./.npmrc;
  };
}
