{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./fastfetch
    ./fd
    ./fzf
    ./home-manager
    ./jq
    ./ripgrep
    ./ssh
    ./tmux
  ];

  home = {
    packages = with pkgs; [
      nil
      nixd
      nixdoc
      nixfmt
      tree
    ];
  };

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  programs = {
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      music = "${config.home.homeDirectory}/Music";
      videos = "${config.home.homeDirectory}/Videos";
      pictures = "${config.home.homeDirectory}/Pictures";
      templates = "${config.home.homeDirectory}/Templates";
      download = "${config.home.homeDirectory}/Downloads";
      documents = "${config.home.homeDirectory}/Documents";
      desktop = "${config.home.homeDirectory}/Desktop";
      publicShare = "${config.home.homeDirectory}/Public";
      extraConfig = {
        XDG_SCREENSHOT_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
      };
    };
    mime = {
      enable = true;
    };
    mimeApps = {
      enable = true;
    };
  };
}
