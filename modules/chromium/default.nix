{ config, lib, pkgs, ... }:{

  imports = [
    ./module.nix
  ];

  services.ungoogledChromium = {
    enable = true;
    extensions = [
      # { name = "extension name"; id = ""; }
      # Note: The ID and details here are illustrative. Actual management needs to be manual or through a compatible tool.
    ];
  };

}
