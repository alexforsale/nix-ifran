{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../common
  ];

  system = {
    stateVersion = "25.11";
  };

  wsl = {
    enable = true;
    defaultUser = "alexforsale";
  };

  networking = {
    hostName = "zanzibar";
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  programs = {
    vim = {
      enable = true;
    };

    git = {
      enable = true;
    };

    gnupg = {
      agent = {
        enable = true;
      };
    };
  };
}
