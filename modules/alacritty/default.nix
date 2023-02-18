# Bundle configuration files into a derivation.
# I call this derivation dotfiles despite that not technically being true
# anymore ...

{ config, pkgs, ...}:

let dotfiles = pkgs.stdenv.mkDerivation {
  name = "alacritty";
  #src = "./";
  srcs = [./configs];

  installPhase = ''
    echo --------------------------------------------------------$out

    mkdir -p $out
    cp ./alacritty.yml $out/
    echo -------------------------$out
  '';
};
in {

  # /etc/ is a special place in NixOS!
  # Symlinks that need to be created there must be specified explicitly.
#  config.xdg.configHome = {
 #   "alacritty.yml".source = "${dotfiles}/alacritty.yml";
#  };

  environment.etc = {
    "alacritty.yml".source    = "${dotfiles}/alacritty.yml";
  };
  environment.systemPackages = with pkgs; [alacritty];
  #environment.interactiveShellInit = ''
  #  alias alacritty2 ${pkgs.alacritty.outPath} --config-file /etc/alacritty
  #'';

}
