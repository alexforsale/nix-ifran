{
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common
    ../users/alexforsale
  ];

  system = {
    stateVersion = "25.11";
  };

  networking = {
    hostName = "angola";
    networkmanager = {
      enable = true;
    };
  };
}
