
{config, pkgs, ...}:{

   nixpkgs.config.allowUnfree = true;
   nixpkgs.config.pulseaudio = true;
   
   imports = [ 
      ./services/printer.nix
      ./modules/nvim
      ./modules/alacritty
      ./modules/i3
      ./modules/git
   ];

  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Bucharest";
 

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vic = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       firefox
       thunderbird
       birdtray
       libreoffice
       logseq
       qbittorrent
       signal-desktop
       qtox
       vlc
       zoom-us
       protonmail-bridge
       speedcrunch
       keepassxc
       killall
       gnupg
       gcc
       valgrind
       gdb
       spotify
       spotify-tray
       cryptsetup
       ledger-live-desktop
       ledger-udev-rules
       prusa-slicer
     ];
   };

}
