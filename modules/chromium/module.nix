{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.ungoogledChromium;
in
{
  options.services.ungoogledChromium = {
    enable = mkEnableOption "ungoogled-chromium with manual extension management";

    # Placeholder for future extension configurations
    extensions = mkOption {
      type = types.listOf types.attrs;
      default = [];
      description = "List of ungoogled-chromium extensions to manage manually.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ungoogled-chromium
      # Future: Add mechanism to facilitate manual extension management
    ];
  };
}

