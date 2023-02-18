
{ config, pkgs, ...}:

let dotfiles = pkgs.stdenv.mkDerivation {
  name = "birdtray";
  srcs = [./configs];

  installPhase = ''
    echo --------------------------------------------------------$out
    mkdir -p $out
    cp ./birdtray-config.json $out/
  '';
};
in {


  environment.etc= {
    "birdtray-config.json".source    = "${dotfiles}/birdtray-config.json";
  };
  
  environment.systemPackages = with pkgs; [birdtray];

}
