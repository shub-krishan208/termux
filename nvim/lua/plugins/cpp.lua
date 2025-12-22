-- ~/.config/nvim/lua/plugins/cpp.lua

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Configure clangd
        clangd = {
          -- 1. Tell Mason NOT to manage this (it avoids the download error)
          mason = false,

          -- 2. Explicitly point to the Termux binary
          -- (Even though it is in your PATH, this guarantees nvim finds the right one)
          cmd = { "/data/data/com.termux/files/usr/bin/clangd" },
        },
      },
    },
  },
}
