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
    ./ripgrep/
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
    tmux = {
      enable = true;
      prefix = "C-a";
      terminal = "tmux-256color";
	    plugins = with pkgs; [
        tmuxPlugins.yank
        tmuxPlugins.tmux-which-key
	    ];
      extraConfig = ''
        unbind C-b
        set -g prefix C-a
        bind a send-prefix
        bind a send-prefix
        bind-key C-a last-window

        set-option -g focus-events on
        set-option -sg escape-time 10
        set -g allow-passthrough on
        setw -g xterm-keys on

	      set-option -a terminal-features '*:RGB'

        setw -g automatic-rename on
        set -g renumber-windows on
        set -g set-titles on
        set -g monitor-activity on
        set -g visual-activity on

        bind -n C-l send-keys C-l \; run 'sleep 0.2' \; clear-history
        bind C-c new-session
        bind C-f command-prompt -p find-session 'switch-client -t %%'
        bind BTab switch-client -l
        bind - split-window -v
        bind _ split-window -h
        bind -r h select-pane -L
        bind -r j select-pane -D
        bind -r k select-pane -U
        bind -r l select-pane -R
        bind > swap-pane -D
        bind < swap-pane -U
        bind -r H resize-pane -L 2
        bind -r J resize-pane -D 2
        bind -r K resize-pane -U 2
        bind -r L resize-pane -R 2

        bind C-p previous-window

        bind p previous-window

        bind C-n next-window
        bind n next-window
        bind Tab last-window

        set -g mouse on
        set-window-option -g mode-keys vi
        bind-key -T copy-mode-vi v send -X begin-selection
        bind-key -T copy-mode-vi y send -X copy-pipe-and-cancel 'wl-copy'
        bind-key p run 'wl-paste --no-newline | tmux load-buffer - ; tmux paste-buffer'
      '';
    };

    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };

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
