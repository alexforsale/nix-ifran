{
  pkgs,
  ...
}:
{
  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        i3status
        i3status-rust
        termite
        rofi
        light
      ];
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-vcs-plugin
        thunar-media-tags-plugin
      ];
    };

    xfconf.enable = true;
  };

  security = {
    pam = {
      services = {
        swaylock = {};
      };
    };
  };

  services = {
    gvfs.enable = true;

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };

    tumbler.enable = true;

    udisks2 = {
      enable = true;
    };
  };

  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  environment.systemPackages = with pkgs; [
    file-roller
    wl-clipboard
    mako
    firefox
    pwvucontrol
  ];
}
