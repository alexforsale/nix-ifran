{
  ...
}:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    historyControl = [
      "ignoredups"
      "erasedups"
      "ignorespace"
    ];
    historyIgnore = [
      "ls"
      "ll"
      "pwd"
      "cd"
      "tree"
      "exit"
    ];
    shellOptions = [
      "histappend"
      "extglob"
      "globstar"
      "checkjobs"
      "checkwinsize"
      "cmdhist"
    ];
    logoutExtra = ''
      if [ "$SHLVL" = 1 ]; then
        [ -x /usr/bin/clear ] && /usr/bin/clear
      fi
    '';
    profileExtra = ''
      stty -ixon
      export CLICOLOR=1
    '';
    shellAliases = {
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      diff = "diff --color=auto";
      ip = "ip --color=auto";
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
    };
    initExtra = ''
      for completion in $HOME/.nix-profile/share/bash-completion/completions/*; do
        source $(readlink -f $completion)
      done
    '';
  };
}
