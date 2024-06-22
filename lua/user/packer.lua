-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local packer = require('packer')
packer.util = require('packer.util')
packer.init({
  snapshot = "stable",
  snapshot_path = packer.util.join_paths(vim.fn.stdpath('cache'), 'packer.nvim'),
})
-- /Users/aaronhunt/.cache/nvim_profiles/lsp-zero/nvim/packer.nvim/stable
return packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use("akinsho/bufferline.nvim") -- Add open buffer tabs
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    --  config = function()
    --   vim.cmd('colorscheme rose-pine')
    -- end
  })
  use({
    "folke/tokyonight.nvim",
    as = 'tokyonight',
  })
  use({
    'xiantang/darcula-dark.nvim',
    as = 'darcula-dark',
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      vim.cmd('colorscheme darcula-dark')
    end
  })
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('nvim-treesitter/nvim-treesitter-context')
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },         -- Required
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' },     -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  }
  use('christoomey/vim-tmux-navigator')  -- Lets <C-h> and <C-l> nav to tmux
  use("jose-elias-alvarez/null-ls.nvim") -- allows formatters and linters to be lsps (enabled eslint_d)
  use("kyazdani42/nvim-web-devicons")
  use("kyazdani42/nvim-tree.lua")
  use("RRethy/vim-illuminate") -- Will soft highlight matches for cursor
  use { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {
    indent = { char = "▏" },
    scope = {
      buftypes = { "terminal", "nofile" },
      filetypes = {
        "help",
        "packer",
        "NvimTree",
      },
    },
  } }                                      -- Shows vertical line for blocks/scopes
  use("moll/vim-bbye")                     -- Allows bufferline to call Bdelete
  use("nvim-lualine/lualine.nvim")         -- Provide botton line context
  use("kylechui/nvim-surround")            -- Advance tpope surround
  use("lewis6991/gitsigns.nvim")
  use("numToStr/Comment.nvim")             -- Allows auto commenting shortcut
  use("goolord/alpha-nvim")                -- Empty screen prompt
  use("windwp/nvim-autopairs")             -- Autopairs, integrates with both cmp and treesitter
  use {
    "antosha417/nvim-lsp-file-operations", -- Auto updates imports for open buffers when a file is moved
    config = function()
      require("lsp-file-operations").setup({ debug = true })
    end
  }
  use { 'https://github.com/apple/pkl-neovim', after = "nvim-treesitter", run = ":TSInstall! pkl" }
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
        plugins = {
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
      }
    end
  }                                        -- Shows keybindings
  use("folke/trouble.nvim")                -- Shows errors and warnings
  use("folke/todo-comments.nvim")          -- Shows TODOs
  use("theprimeagen/refactoring.nvim")
  use("https://tpope.io/vim/fugitive.git") -- Git commands
end)
