{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.fetchGithubScript;
in
{
  options.services.fetchGithubScript = {
    enable = mkEnableOption "Fetch script from GitHub";

    owner = mkOption {
      type = types.str;
      default = "";
      description = "GitHub owner or organization of the repository.";
    };

    repo = mkOption {
      type = types.str;
      default = "";
      description = "GitHub repository name.";
    };

    rev = mkOption {
      type = types.str;
      default = "";
      description = "Git revision such as a commit hash or branch name.";
    };

    sha256 = mkOption {
      type = types.str;
      default = "";
      description = "SHA256 hash of the repository contents.";
    };

    scriptPath = mkOption {
      type = types.str;
      default = "";
      description = "Path to the script within the repository.";
    };

    dependencies = mkOption {
      type = types.listOf types.package;
      default = [];
      example = literalExample "[ pkgs.jq pkgs.curl ]";
      description = "List of Nix package dependencies required by the script.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (let
        scriptSrc = fetchFromGitHub {
          owner = cfg.owner;
          repo = cfg.repo;
          rev = cfg.rev;
          sha256 = cfg.sha256;
        };
        scriptPkg = stdenv.mkDerivation {
          name = "github-script";
          src = scriptSrc;

          installPhase = ''
            mkdir -p $out/bin
            cp ${scriptSrc}/${cfg.scriptPath} $out/bin/${cfg.scriptPath}
            chmod +x $out/bin/${cfg.scriptPath}
          '';
        };
      in scriptPkg)
    ] ++ cfg.dependencies;
  };
}

