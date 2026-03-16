{
  lib,
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = lib.fileContents ./init.lua;
    extraPackages = with pkgs; [
      lua-language-server
      stylua
      python3Packages.python-lsp-server
      bash-language-server
      marksman
      taplo
      yaml-language-server
      gopls
      vscode-langservers-extracted
      typescript-language-server
      eslint
    ];
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''

          require('nvim-treesitter.configs').setup {
            highlight = { enable = true },
            indent = { enable = false },
          }
        '';
      }
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp_luasnip
      luasnip
      {
        plugin = nvim-cmp;
        type = "lua";
        config = lib.fileContents ./plugins/nvim-cmp.lua;
      }
    ];
  };
}
