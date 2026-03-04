{
  config,
  pkgs,
  ...
}:
{
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
          gamemode
          jdk
        ];
    };
  };

  programs.steam = {
    enable = true;
    extest.enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraPackages = with pkgs; [
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib
      libkrb5
      keyutils
    ];
  };
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  programs.gamescope.capSysNice = false;
  hardware.xone.enable = true;
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ xone ];
  };
  networking.firewall.allowedTCPPorts = [ 24872 ];
  networking.firewall.allowedUDPPorts = [ 24872 ];
}
