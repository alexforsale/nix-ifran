{
  pkgs,
  ...
}:
{
  services.remmina = {
    enable = true;
    systemdService = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    libsecret
  ];
}
