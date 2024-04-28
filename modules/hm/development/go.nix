{ pkgs, ... }: { home.packages = with pkgs; [ go gore go-tools gotestsum ]; }
