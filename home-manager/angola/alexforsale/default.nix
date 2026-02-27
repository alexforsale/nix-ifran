{
  config,
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
    ../../common/zathura
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

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age = {
      sshKeyPaths = [
        "${config.home.homeDirectory}/.ssh/id_ed25519"
      ];
    };
    secrets = {
      "applications/syncthing/password" = {};
      "applications/syncthing/cert" = {};
      "applications/syncthing/key" = {};
    };
  };

  services = {
    syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
      cert = config.sops.secrets."applications/syncthing/cert".path;
      key = config.sops.secrets."applications/syncthing/key".path;
      passwordFile = config.sops.secrets."applications/syncthing/password".path;
    };
  };
}
