

{config, lib, pkgs, ...}:
  with pkgs;
  let
    terminal = "${pkgs.alacritty}/bin/alacritty --config-file /etc/alacritty.yml";
    filemanager = "${terminal} -e ${pkgs.ranger}/bin/ranger";
    editor = "${terminal} -e ${pkgs.vim}/bin/vim";
    browser = "${pkgs.firefox}/bin/firefox";
    mail = "${pkgs.thunderbird}/bin/thunderbird";
    mail_tray = "${pkgs.birdtray}/bin/birdtray";
    background = "/etc/background.png";
  in
{

  imports = [
    ../../services/xserver.nix
    ../../services/picom.nix
    ../polybar
  ];

  environment.etc."background.png".source = ./background.png;
  environment.etc."i3.conf".text = pkgs.callPackage ./generate-config.nix {
    pkgs=pkgs;terminal=terminal; editor=editor; filemanager=filemanager; browser=browser; mail=mail;
    mail_tray=mail_tray; background=background;
  };
  
  
  services.xserver.displayManager={
	defaultSession="none+i3";
  };
  
  services.xserver.windowManager.i3={
    enable=true;
    package = pkgs.i3-gaps;
    extraPackages=with pkgs; [
      dmenu
      i3status
      i3lock
      i3blocks
      clipmenu
      feh
      ranger
      gnome.gnome-keyring
    ];

    extraSessionCommands = ''
      gnome-keyring-daemon --start -d --components=pkcs11,secrets,ssh
    '';

    configFile = "/etc/i3.conf";
  };
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
}
