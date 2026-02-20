{
  pkgs,
  ...
}:
{
  imports = [
    ../../common
  ];

  home = {
    username = "alexforsale";
    homeDirectory = "/home/alexforsale";
    stateVersion = "25.11";

  };

  programs = {
    emacs = {
      enable = true;
      package = pkgs.myEmacs;
    };
  };
}
