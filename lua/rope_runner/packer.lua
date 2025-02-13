-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', 
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function ()
            require("telescope").setup({
                extensions = {
                    projects = {
                        base_dirs = { "~/job", "~/learn", "~/projects" },
                        hidden_files = true
                    }
                }
            })
        end
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
        'NeogitOrg/neogit', tag = 'v0.0.1',
        requires = {
            { 'sindrets/diffview.nvim' },
        }
    }

    use 'APZelos/blamer.nvim'

    use "EdenEast/nightfox.nvim"

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            {'neovim/nvim-lspconfig'},
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }

    use 'akinsho/git-conflict.nvim'

    use {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup({
                bind = true,
                hint_prefix = "→ ",
                floating_window = true,
                always_trigger = true,
            })
        end
    }

    use   {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    }

    use   {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                manual_mode = false,  -- Set to true if you want to manually add projects
                detection_methods = { "pattern" }, -- Detect based on patterns (not just .git)
                patterns = { ".git", "Makefile", "package.json" }, -- What counts as a project
                ignore_lsp = {}, -- Don't exclude any LSP projects
                show_hidden = true, -- Show hidden files in project list
                silent_chdir = false, -- Show messages when switching projects
                datapath = vim.fn.stdpath("data"), -- Store project history
            }
            require("telescope").load_extension("projects")
        end
    }

    use {
        'christoomey/vim-tmux-navigator'
    }

    --use {
        --    'nvim-tree/nvim-tree.lua',
        --    requires = {
            --        'nvim-tree/nvim-web-devicons',
            --    },
            --}
        end)
