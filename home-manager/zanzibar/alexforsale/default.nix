{
  pkgs,
  ...
}:
{
  imports = [
    ../../common
    ../../common/bash
    ../../common/emacs
    ../../common/password-store
  ];

  home = {
    username = "alexforsale";
    homeDirectory = "/home/alexforsale";
    stateVersion = "25.11";
    packages = with pkgs; [
      wl-clipboard
      hunspellDicts.en_US-large
      hunspellDicts.id_ID
      nerd-fonts.iosevka
    ];
  };
}
