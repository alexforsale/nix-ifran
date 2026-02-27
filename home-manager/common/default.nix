{
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
    ./xdg
    ./zoxide
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

  systemd.user.startServices = "suggest";
}
