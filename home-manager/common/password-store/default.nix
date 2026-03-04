{
  pkgs,
  ...
}:
{
  programs = {
    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [
        exts.pass-otp
      ]);
    };
  };

  home.packages = with pkgs; [
    pass-git-helper
  ];
}
