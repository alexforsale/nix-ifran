{
pkgs,
}:
let
  myEmacs = pkgs.emacs-pgtk;
  emacsWithPackages = (pkgs.emacsPackagesFor myEmacs).emacsWithPackages;
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-medium
    dvisvgm dvipng # for preview and export as html
    wrapfig amsmath ulem hyperref capt-of;
    #(setq org-latex-compiler "lualatex")
    #(setq org-preview-latex-default-process 'dvisvgm)
  });
  in
  emacsWithPackages (
    epkgs:
    (with epkgs.melpaStablePackages; [
      magit
      markdown-mode
      multiple-cursors
      notmuch-addr
      nix-ts-mode
      ol-notmuch
      ox-hugo
      pdf-tools
      rainbow-delimiters
      rainbow-identifiers
      yaml-pro
      (epkgs.treesit-grammars.with-grammars
        (grammars:
       [
         grammars.tree-sitter-bash
         grammars.tree-sitter-nix
         grammars.tree-sitter-python
         grammars.tree-sitter-yaml
         grammars.tree-sitter-toml
         grammars.tree-sitter-json
       ]))
    ]) ++ [
      tex
      pkgs.nixd
      pkgs.nixpkgs-fmt
      pkgs.hunspell
      pkgs.hunspellDicts.en_US-large
      pkgs.hunspellDicts.id_ID
      pkgs.taplo
      pkgs.lua-language-server
      pkgs.marksman
      pkgs.yaml-language-server
      pkgs.gopls
      pkgs.vscode-langservers-extracted
      pkgs.bash-language-server
      pkgs.python3Packages.python-lsp-server
      pkgs.typescript-language-server
      pkgs.eslint
      pkgs.emmet-ls
      pkgs.emacsPackages.org-contrib
      pkgs.emacsPackages.rainbow-mode
      pkgs.emacsPackages.org-rainbow-tags
      pkgs.emacsPackages.indent-bars
      pkgs.emacsPackages.notmuch-indicator
      pkgs.hugo
      pkgs.notmuch
    ]
  )
