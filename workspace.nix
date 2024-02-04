
{config, pkgs, ...}:

{  
   nixpkgs.config.allowUnfree = true;
   
   imports = [
      ./minimal-ui.nix
      ./services/printer.nix
   ];


  
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.vic.packages = with pkgs; [
      logseq
      qbittorrent
      signal-desktop
      qtox
      vlc
      zoom-us
      gcc
      valgrind
      gdb
      spotify
      spotify-tray
      prusa-slicer
      freecad
      php
      darktable
      gimp
   ];

}
