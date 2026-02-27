{
  ...
}:
{
  services.wpaperd = {
    enable = true;

    settings = {
      "DP-1" = {
        path = "~/.local/share/wallpapers/solarized";
        duration = "10m";
      };
      "DP-2" = {
        path = "~/.local/share/wallpapers/solarized";
        duration = "20m";
      };
      "LVDS-1" = {
        path = "~/.local/share/wallpapers/nord";
        duration = "10m";
      };
      "HDMI-A-2" = {
        path = "~/.local/share/wallpapers/nord";
        duration = "10m";
      };
    };
  };
}
