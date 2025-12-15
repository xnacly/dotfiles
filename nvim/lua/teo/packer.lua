local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
    download_result = fn.system({ 'ls', '-l', install_path })
    print("download_result: " .. download_result)
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'lervag/vimtex'

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                mapping = {
                    ["<C-n>"] = cmp.mapping.select_next_item { behaviour = cmp.SelectBehavior.Insert },
                    ["<C-p>"] = cmp.mapping.select_prev_item { behaviour = cmp.SelectBehavior.Insert },
                    ["<Tab>"] = cmp.mapping(
                        cmp.mapping.confirm {
                            behaviour = cmp.SelectBehavior.Insert,
                            select = true,
                        },
                        { "i", "c" }
                    ),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'buffer' },
                }),
            })
        end
    }

    -- todo comments
    use {
        'folke/todo-comments.nvim',
        config = function() require("todo-comments").setup() end
    }

    -- git integration
    use 'lewis6991/gitsigns.nvim'

    -- toggle floating term
    use 'akinsho/toggleterm.nvim'

    -- color theme / sheme
    -- use {
    --     'folke/tokyonight.nvim',
    --     branch = 'main',
    --     config = function() vim.cmd([[colorscheme tokyonight-night]]) end
    -- }
    -- use {
    --     "bluz71/vim-moonfly-colors",
    --     as = "moonfly",
    --     config = function() vim.cmd([[colorscheme moonfly]]) end
    -- }
    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            require("catppuccin").setup {
                transparent_background = true,
            }
            vim.cmd([[colorscheme catppuccin-latte]])
        end
    }

    -- comment helper
    use 'tpope/vim-commentary'

    -- fuzzy finder
    use {
        'nvim-telescope/telescope.nvim',
        config = function() require("telescope").setup() end,
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    -- status line
    use 'nvim-lualine/lualine.nvim'

    -- file explorer
    use {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require("nvim-tree").setup({
                view = {
                    adaptive_size = true,
                },
                renderer = {
                    full_name = true,
                    group_empty = true,
                    special_files = {},
                    symlink_destination = false,
                    indent_markers = {
                        enable = true,
                    },
                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = true,
                        },
                    },
                },
            })
        end
    }

    -- icons for everything, file explorer, tabs, statusline
    use {
        'nvim-tree/nvim-web-devicons',
        config = function() require('nvim-web-devicons').setup() end
    }

    -- automatically add "([ pairs if first one is typed
    use 'jiangmiao/auto-pairs'

    -- color highlighting
    use {
        'norcalli/nvim-colorizer.lua',
        config = function() require("colorizer").setup() end
    }

    -- syntax highlighting and parser
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- vuejs
    use {
        'yaegassy/coc-volar',
        run = 'yarn install --frozen-lockfile'
    }
    use {
        'yaegassy/coc-volar-tools',
        run = 'yarn install --frozen-lockfile'
    }
end)
