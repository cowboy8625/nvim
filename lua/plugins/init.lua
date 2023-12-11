return {
  -- {
  --   dir = "~/Documents/NeovimPlugins/twitch_watch",
  --   dependencies = { "rcarriga/nvim-notify" },
  --   config = true,
  -- },

  "rhaiscript/vim-rhai",
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  "nvim-tree/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",
  "bluz71/vim-nightfly-colors",
  "vim-test/vim-test",
  "preservim/vimux",
  "christoomey/vim-tmux-navigator",
  -- completion
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  {
    config = true,
    "numToStr/Comment.nvim",
  },
  -- Rust
  "neovim/nvim-lspconfig",
  -- Debugging
  "nvim-lua/plenary.nvim",
  "krady21/compiler-explorer.nvim",
  "folke/neodev.nvim",
}
