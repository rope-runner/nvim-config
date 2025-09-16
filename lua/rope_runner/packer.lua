vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'neovim/nvim-lspconfig'
    use {'williamboman/mason.nvim'}
    use({ 'saghen/blink.cmp', tag = "1.6" })

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

    use 'akinsho/git-conflict.nvim'

    use "namrabtw/rusty.nvim"

    use({
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end,
    })
end)
