local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use {
    '~/Documents/NeovimPlugins/twitch_watch.nvim',
    requires = 'rcarriga/nvim-notify'
  }
  use {
    'Exafunction/codeium.vim',
    config = function ()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
  end
}
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim'
  }

  -- use {
  --   's1n7ax/nvim-terminal',
  --   config = function()
  --       vim.o.hidden = true
  --       require('nvim-terminal').setup()
  --   end,
  -- }

  use 'lewis6991/gitsigns.nvim'

  use {
    'ojroques/nvim-lspfuzzy',
    requires = {
      {'junegunn/fzf'},
      {'junegunn/fzf.vim'},  -- to enable preview (optional)
    },
  }

  use 'wbthomason/packer.nvim'
  use 'ellisonleao/gruvbox.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'bluz71/vim-nightfly-colors'
  use 'vim-test/vim-test'
  use 'lewis6991/gitsigns.nvim'
  use 'preservim/vimux'
  use 'christoomey/vim-tmux-navigator'
  -- completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'

  use {'stevearc/dressing.nvim'}

  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
  }
  use {
	  'nvim-telescope/telescope.nvim',
	  tag = '0.1.0',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'numToStr/Comment.nvim'

  -- Rust
  use 'simrat39/rust-tools.nvim'

  -- Debugging
  use 'nvim-lua/plenary.nvim'
  use 'mfussenegger/nvim-dap'

  use {'krady21/compiler-explorer.nvim'}

  use 'folke/neodev.nvim'

  -- use {
  --   'folke/zen-mode.nvim',
  --   config = function()
  --     require('zen-mode').setup {
  --       options = {
  --         signcolumn = 'no', -- disable signcolumn
  --         number = false, -- disable number column
  --         relativenumber = false, -- disable relative numbers
  --         cursorline = false, -- disable cursorline
  --         cursorcolumn = false, -- disable cursor column
  --         foldcolumn = '0', -- disable fold column
  --         list = false, -- disable whitespace characters
  --       },
  --       plugins = {
  --         -- disable some global vim options (vim.o...)
  --         -- comment the lines to not apply the options
  --         options = {
  --           enabled = true,
  --           ruler = false, -- disables the ruler text in the cmd line area
  --           showcmd = false, -- disables the command in the last line of the screen
  --         },
  --         twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
  --         gitsigns = { enabled = false }, -- disables git signs
  --         tmux = { enabled = false }, -- disables the tmux statusline
  --         -- this will change the font size on kitty when in zen mode
  --         -- to make this work, you need to set the following kitty options:
  --         -- - allow_remote_control socket-only
  --         -- - listen_on unix:/tmp/kitty
  --         kitty = {
  --           enabled = false,
  --           font = '+4', -- font size increment
  --         },
  --         -- this will change the font size on alacritty when in zen mode
  --         -- requires  Alacritty Version 0.10.0 or higher
  --         -- uses `alacritty msg` subcommand to change font size
  --         alacritty = {
  --           enabled = false,
  --           font = '14', -- font size
  --         },
  --       },
  --     }
  --   end
  -- }
  --
  -- use {
  --   'nvim-neorg/neorg',
  --   run = ':Neorg sync-parsers', -- This is the important bit!
  --   config = function()
  --     require('neorg').setup {
  --       load = {
  --         ['core.defaults'] = {},
  --         ['core.export'] = {},
  --         ['core.export.markdown'] = {},
  --         -- ['core.norg.completion'] = { config = { engine='nvm-cmp'}},
  --         ['core.norg.concealer'] = { config = { dim_code_block={conceal=false}}},
  --         ['core.presenter'] = { config = { zen_mode='zen-mode'}},
  --         ['core.itero'] = {},
  --         -- ['core.jupyter'] = {},
  --         -- ['core.execute'] = {},
  --         ['core.norg.dirman'] = {
  --           config = {
  --           workspaces = {
  --             notes = '~/notes',
  --             }
  --           }
  --         }
  --       }
  --     }
  --   end,
  --   requires = 'nvim-lua/plenary.nvim',
  -- }
  --
  -- use { 'folke/twilight.nvim' }

  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('todo-comments').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    'johnfrankmorgan/whitespace.nvim',
    config = function ()
        require('whitespace-nvim').setup({
            -- configuration options and their defaults

            -- `highlight` configures which highlight is used to display
            -- trailing whitespace
            highlight = 'DiffDelete',

            -- `ignored_filetypes` configures which filetypes to ignore when
            -- displaying trailing whitespace
            ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help' },
        })

        -- remove trailing whitespace with a keybinding
        vim.keymap.set('n', '<Leader>t', require('whitespace-nvim').trim)
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
