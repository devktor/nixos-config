{ config, pkgs, ... }:
 let 
      pythonEnv = pkgs.python3.withPackages (ps: with ps; [
         mnemonic
      ]);

in
{
  imports = [
    ../../modules/github-script
  ];

  services.fetchGithubScript = {
    enable = true;
    owner = "devktor";
    repo = "keyutils";
    rev = "v0.0.1";
    sha256 = "g99vflY/Ahrf1l5cyVZLyNxQ3x4ssSV0NbtKOJ6Gj8w="; # Use the actual SHA256 hash
    scriptPath = "gen_bip39.py";
    dependencies = [ pythonEnv ];
  };

  # Your other configurations...
}

