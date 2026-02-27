{
  ...
}:
{
  programs = {
    git = {
      enable = true;
      lfs = {
        enable = true;
      };
      settings = {
        core = {
          editor = "nvim";
        };
        commit = {
          gpgsign = true;
        };
        color = {
          ui = true;
        };
        credential = {
          helper = "!pass-git-helper $@";
        };
        difftool = {
          prompt = true;
        };
        diff = {
          tool = "nvimdiff";
        };
        difttool."nvimdiff" = {
          cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
        };
        merge = {
          tool = "nvim";
        };
        mergetool."nvim" = {
          cmd = "nvim -d -c \"wincmd l\" \"$LOCAL\" \"$MERGED\" \"$REMOTE\"";
          keepBackup = false;
        };
        init = {
          defaultBranch = "main";
        };
        pack = {
          windowMemory = "2g";
          packSizeLimit = "1g";
        };
        pull = {
          rebase = true;
        };
        push = {
          default = "simple";
        };
        tag = {
          gpgSign = true;
        };
        user = {
          name = "alexforsale";
          email = "alexforsale@yahoo.com";
          signingkey = "CDBB05B232787FCC";
        };
      };
    };
  };
}
