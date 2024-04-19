{ pkgs, ... }: {
  home.packages = with pkgs; [
    docker
    docker-credential-helpers
    lazydocker
    k9s
    minikube
    kubectl
  ];
}
