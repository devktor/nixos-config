
{ config, pkgs, ...}:

let dotfiles = pkgs.stdenv.mkDerivation {
  name = "polybar";
  srcs = [./configs];

  installPhase = ''
    echo --------------------------------------------------------$out
    echo --- ${pkgs.polybar}
    mkdir -p $out
    cp ./config.ini $out/
  '';
};
in {


  environment.etc= {
    "polybar/config.ini".source    = "${dotfiles}/config.ini";
  };
  
  environment.systemPackages = with pkgs; [polybar];

}
