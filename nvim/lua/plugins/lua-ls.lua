return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          mason = false, -- Tell LazyVim/Mason not to manage this
        },
      },
    },
  },
}
