{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  time = {
    timeZone = "Asia/Jakarta";
  };


  programs.nix-ld.enable = true;
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

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
    };
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # ssh
      ];
      allowedUDPPorts = [
        22
        9993 # zerotierone
      ];
    };
    hosts = {
      "10.254.254.10" = [ "zaire" ];
      "10.254.254.11" = [ "kenya" ];
      "10.254.254.12" = [ "madagascar" ];
      "10.254.254.13" = [ "burundi" ];
      "10.254.254.15" = [ "algeria" ];
    };
  };

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = config.i18n.defaultLocale;
    LC_IDENTIFICATION = config.i18n.defaultLocale;
    LC_MEASUREMENT = config.i18n.defaultLocale;
    LC_MONETARY = config.i18n.defaultLocale;
    LC_NAME = config.i18n.defaultLocale;
    LC_NUMERIC = config.i18n.defaultLocale;
    LC_PAPER = config.i18n.defaultLocale;
    LC_TELEPHONE = config.i18n.defaultLocale;
    LC_TIME = config.i18n.defaultLocale;
  };

  environment.systemPackages = with pkgs; [
    wget
    sops
    age
    ntfs3g
    dig
    nmap
    traceroute
    tcpdump
    iperf
    whois
    nfs-utils
    htop
    pciutils
    usbutils
    file
  ];

  programs = {
    git = {
      enable = true;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    nano.enable = lib.mkForce false;

    vim = {
      enable = true;
    };
  };

  security = {
    rtkit = {
      enable = true;
    };
  };

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
      };
    };

    fwupd= {
      enable = true;
    };

    logrotate = {
      enable = true;
    };

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    timesyncd = {
      enable = true;
    };

    zerotierone = {
      enable = true;
    };
  };
}
