return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'EdenEast/nightfox.nvim' -- Nightfox colorscheme
  use 'nvim-tree/nvim-tree.lua'
  use 'rcarriga/nvim-notify' 
  
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'nvim-tree/nvim-web-devicons'
  use 'romgrk/barbar.nvim'
  use 'nvim-lualine/lualine.nvim'

  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'HiPhish/nvim-ts-rainbow2'
  use 'nvim-treesitter/nvim-treesitter'
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lua/plenary.nvim'

  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  use 'm4xshen/autoclose.nvim'
  use 'folke/trouble.nvim' -- Diagnostics plugin
  use 'onsails/lspkind.nvim'
  use 'mfussenegger/nvim-dap'

  use 'rcarriga/nvim-dap-ui'
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
  require("toggleterm").setup()
end}
end)
