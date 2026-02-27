{
  pkgs,
  ...
}:
{
  imports = [
    ../../common
    ../../common/bash
    ../../common/emacs
    ../../common/git
    ../../common/mpd
    ../../common/mpv
    ../../common/password-store
    ./sway
  ];

  home = {
    username = "alexforsale";
    homeDirectory = "/home/alexforsale";
    stateVersion = "25.11";
    packages = with pkgs; [
      pass-git-helper
      hunspell
      hunspellDicts.en_US-large
      hunspellDicts.id_ID
      gruvbox-gtk-theme
    ];
  };
}
