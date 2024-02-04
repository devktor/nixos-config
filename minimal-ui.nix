
{config, pkgs, ...}:

{  
   nixpkgs.config.pulseaudio = true;
   
   imports = [
      ./minimal.nix
      ./modules/alacritty
      ./modules/i3
   ];

   users.users.vic.packages = with pkgs; [
      chromium
      firefox
      thunderbird
      birdtray
      libreoffice
      protonmail-bridge
      speedcrunch
      keepassxc
     ];
}
