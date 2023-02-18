{pkgs, ...} : {

#   environment.systemPackages = with pkgs; [
#	rxvt_unicode
#   ];

   services.xserver = {

      enable = true;
      libinput.enable = true;

      desktopManager = {
	 xterm.enable = false;
      };
      
      displayManager.lightdm.greeters.slick = {

	 enable = true;
	 extraConfig = ''
	    # background-color = "#002b36"
	 '';
	 font.name = "Iosevka";
	 font.package = pkgs.iosevka;
      }; 

   };

   environment.variables.EDITOR = "vim";
   #environment.variables.SHELL = "alacritty --config-file /etc/alacritty.yml";

}
