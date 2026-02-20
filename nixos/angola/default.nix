{
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common
    ../users/alexforsale
  ];

  networking = {
    hostName = "angola";
    networkmanager = {
      enable = true;
    };
  };

  system = {
    stateVersion = "25.11";
  };
}
