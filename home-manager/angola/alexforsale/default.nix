{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ../../common
    ../../common/bash
    ../../common/brave
    ../../common/emacs
    ../../common/git
    ../../common/mpd
    ../../common/mpv
    ../../common/password-store
    ./mail.nix
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
      "applications/syncthing/password" = { };
      "applications/syncthing/cert" = { };
      "applications/syncthing/key" = { };
    };
  };

  services = {
    syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
      cert = config.sops.secrets."applications/syncthing/cert".path;
      key = config.sops.secrets."applications/syncthing/key".path;
      passwordFile = config.sops.secrets."applications/syncthing/password".path;

      settings = {
        devices = {
          "CPH2273" = {
            name = "CPH2273";
            id = "E55TRAX-5N7NP6F-TFT6XPI-E3BELPI-WNS2FD6-PINZZQE-I4ZUV56-BUL4VQM";
          };
          "burundi" = {
            name = "burundi";
            id = "YYX22VO-4JGE5BK-M4BWTUQ-IBJYK7T-GIDRQHL-KDA3SPV-NPAMPT7-MH6WHQY";
          };
        };

        folders = {
          "/home/${config.home.username}/Sync" = {
            id = "default";
            path = "~/Sync";
            label = "Default Folder";
            devices = [
              "CPH2273"
              "burundi"
            ];
          };

          "/home/${config.home.username}/Music" = {
            id = "amjxx-hcorl";
            path = "~/Music";
            label = "Music";
            devices = [
              "CPH2273"
              "burundi"
            ];
          };
        };
      };
    };
  };

  xdg = {
    dataFile = {
      "wallpapers" = {
        source = inputs.wallpapers + "/.local/share/wallpapers";
        recursive = true;
      };
    };

    desktopEntries = {
      org-protocol = {
        name = "Org-Protocol";
        exec = "emacsclient %u";
        mimeType = [
          "x-sheme-handler/org-protocol"
        ];
        terminal = false;
        icon = "emacs-icon";
        type = "Application";
      };
    };
  };
}
