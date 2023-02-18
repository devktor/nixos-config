
{config, pkgs, ...}:{

   services.blueman.enable = true;
   networking.hostName = "workspacE1";
   imports = 
   [ 
      ./workspace.nix
   ];


}
