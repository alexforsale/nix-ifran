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
    ../common/avahi
    ../common/bluetooth
    ../common/brave
    ../common/thunar
    ../common/kdeconnect
    ../common/steam
    ../common/zerotierone
    ../users/alexforsale
  ];

  networking = {
    firewall = {
      allowedTCPPorts = [
        22000
        8384
      ];
      allowedUDPPorts = [
        22000
        21027
      ];
    };
    hostName = "angola";
    networkmanager = {
      enable = true;
    };
  };

  programs.sway.enable = true;

  security = {
    pam = {
      loginLimits = [
        {
          domain = "@users";
          item = "rtprio";
          type = "-";
          value = 1;
        }
      ];
    };
    polkit.enable = true;
  };

  services = {
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

    timesyncd = {
      enable = true;
    };
  };

  environment.systemPackages = [
    custom-sddm-astronaut
  ];

  system = {
    stateVersion = "25.11";
  };
}
