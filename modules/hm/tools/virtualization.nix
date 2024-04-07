{ pkgs, ... }: {
  home.packages = with pkgs; [ docker lazydocker k9s minikube kubectl ];
}
