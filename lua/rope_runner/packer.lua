-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    --use {'neovim/nvim-lspconfig'}
    --
use 'neovim/nvim-lspconfig'
    use {'williamboman/mason.nvim'}
    --use { 'hrsh7th/nvim-cmp' }
    --use { 'hrsh7th/cmp-nvim-lsp' }
    --use { 'L3MON4D3/LuaSnip' }

    --use 'hrsh7th/cmp-cmdline'
    --use 'hrsh7th/cmp-path'
    --use 'hrsh7th/cmp-buffer'
    --
use({ 'saghen/blink.cmp' })

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })

    use	"folke/tokyonight.nvim"

    --use { "scottmckendry/cyberdream.nvim" }

use { "scottmckendry/cyberdream.nvim" }

    use "windwp/nvim-ts-autotag"

    use "jose-elias-alvarez/null-ls.nvim"

    use "MunifTanjim/prettier.nvim"

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use {
        'sindrets/diffview.nvim',
        requires = { 'nvim-tree/nvim-web-devicons' }, -- ensures icons are available
    }

    use {
        'NeogitOrg/neogit',
        requires = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
        },
        config = function()
            require('neogit').setup({
                integrations = { diffview = true },
            })
        end
    }
    use 'APZelos/blamer.nvim'

    use "EdenEast/nightfox.nvim"

    

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    --use {
    --    'VonHeikemen/lsp-zero.nvim',
    --    branch = 'v3.x',
    --    requires = {
    --        {'williamboman/mason.nvim'},
    --        {'williamboman/mason-lspconfig.nvim'},
    --        {'neovim/nvim-lspconfig'},
    --        {'hrsh7th/nvim-cmp'},
    --        {'hrsh7th/cmp-nvim-lsp'},
    --        {'L3MON4D3/LuaSnip'},
    --    }
    --}

    use 'akinsho/git-conflict.nvim'

    use "namrabtw/rusty.nvim"

    --use {
    --    "ray-x/lsp_signature.nvim",
    --    config = function()
    --        require("lsp_signature").setup({
    --            bind = true,
    --            hint_prefix = "→ ",
    --            floating_window = true,
    --            always_trigger = true,
    --        })
    --    end
    --}

    --use {
    --    "ray-x/lsp_signature.nvim",
    --    config = function()
    --        require("lsp_signature").setup({
    --            bind = true,
    --            floating_window = true,
    --            hint_enable = true,
    --            handler_opts = {
    --                border = "rounded"
    --            }
    --        })
    --    end
    --}

    --use {
    --    'nvim-tree/nvim-tree.lua',
    --    requires = {
    --        'nvim-tree/nvim-web-devicons',
    --    },
    --}
end)
