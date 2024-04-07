{ pkgs, ... }: {
  home.packages = with pkgs; [ ghc ormolu stack cabal-install ];
}
