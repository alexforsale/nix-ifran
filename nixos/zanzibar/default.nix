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
    wslConf = {
      boot.systemd = true;
      boot.initTimeout = 40000;
    };
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
