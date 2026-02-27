{
  config,
  ...
}:
{
  sops = {
    secrets = {
      "users/alexforsale/password".neededForUsers = true;
      "apps/mpdscribble/alexforsale/password" = {
        owner = "alexforsale";
        mode = "0440";
        path = "/var/tmp/mpdscribble.password";
      };
    };
  };

  users.users.alexforsale = {
    isNormalUser = true;
    description = "Kristian Alexander P";
    hashedPasswordFile = config.sops.secrets."users/alexforsale/password".path;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "lp"
      "rtkit"
    ];
    openssh = {
      authorizedKeys = {
        keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBCLH0bm4WIIGdhRgq89lpah+BCDtEv2lCeiGmyOIJpR alexforsale@yahoo.com"
        ];
      };
    };
  };
}
