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

  programs.sway.enable = true;

  security = {
    polkit.enable = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;
    pipewire.enable = true;
  };
  
  system = {
    stateVersion = "25.11";
  };
}
