{
  pkgs,
  ...
}:
{
  home = {
    username = "alexforsale";
    homeDirectory = "/home/alexforsale";
    stateVersion = "25.11";
    packages = with pkgs; [
      wl-clipboard
    ];
  };
}
