
{config, pkgs, ...}:
{  
   
   imports = [ 
      ./modules/nvim
      ./modules/git
      ./modules/keyutils
   ];

  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Bucharest";

  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vic = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       killall
       gnupg
       cryptsetup
       unzip
       ssss
       bitcoin
       go-ethereum
       openssl
     ];
   };

}
