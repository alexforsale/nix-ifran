{
  pkgs,
  ...
}:
let
  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "post-apocalyptic_hacker";
    themeConfig.ScreenWidth = "1440";
    themeConfig.ScreenHeight = "900";
    themeConfig.FontSize = "11";
  };
in
{
  imports = [
    ./hardware-configuration.nix
    ../common
    ../users/alexforsale
  ];

  networking = {
    firewall = {
      allowedTCPPorts = [ 22000 8384 ];
      allowedUDPPorts = [ 22000 21027 ];
    };
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
    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      openFirewall = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
      };
    };

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        autoNumlock = true;
        settings = {
          General = {
            InputMethod = "qtvirtualkeyboard";
          };
        };
        theme = "sddm-astronaut-theme";
        extraPackages = [
          custom-sddm-astronaut
          pkgs.kdePackages.qtsvg
          pkgs.kdePackages.qtmultimedia
          pkgs.kdePackages.qtvirtualkeyboard
        ];
      };
    };

    gnome.gnome-keyring.enable = true;

    pipewire.enable = true;

    syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
    };
  };

  environment.systemPackages = [
    custom-sddm-astronaut
  ];

  system = {
    stateVersion = "25.11";
  };
}
