{ pkgs, ... }: {
  home = {
    packages = with pkgs; [ jdk gradle maven google-java-format ];
    file = { ".java/jdk".source = pkgs.jdk17; };
    sessionVariables = { JAVA_HOME = "$HOME/.java/jdk"; };
  };
}
