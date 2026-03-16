vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.autochdir = true

vim.lsp.config(
  "*", {
    root_marker = { ".git" },
    capabilities = {
      textDocument = {
        semanticTokens = {
          multilineTokenSupport = true,
        },
      },
    },
  }
)

vim.lsp.config.nixd = {
  cmd = { "nixd" },
  formatting = {
    command = { "nixpkgs-fmt" },
    settings = {
      nixd = {
        nixpkgs = {
          expr = 'import (builtins.getFlake "/etc/nixos").inputs.nixpkgs { }',
        },
        formatting = {
          command = { "nixpkgs-fmt" },
        },
        options = {
          nixos = {
            expr = '(builtins.getFlake "/etc/nixos").nixosConfigurations.' .. vim.uv.os_gethostname() .. '.options',
          },
          home_manager = {
            expr = '(builtins.getFlake "/etc/nixos").homeConfigurations."' .. vim.env.USER .. '@' .. vim.uv.os_gethostname() .. '".options',
          },
        },
      },
    },
  },
}

vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  root_marker = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJit",
        path = { "lua/?.lua", "lua/?/init.lua" },
      },
      diagnostics = {
        globals = {"vim"},
      },
    },
  },
}

-- for testings
local file_path = vim.fn.expand("~/.config/nvim/staging.lua")
if vim.fn.glob(file_path) ~= "" then
  vim.cmd("source" .. file_path)
end
