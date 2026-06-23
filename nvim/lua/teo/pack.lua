-- Build hooks: run on install/update via PackChanged events.
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if kind ~= 'install' and kind ~= 'update' then return end

        if name == 'markdown-preview.nvim' then
            if not ev.data.active then vim.cmd.packadd('markdown-preview.nvim') end
            vim.fn['mkdp#util#install']()
        elseif name == 'nvim-treesitter' then
            if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
            vim.cmd('TSUpdate')
        end
    end,
})

vim.pack.add({
    'https://github.com/neovim/nvim-lspconfig',

    'https://github.com/folke/todo-comments.nvim',

    -- git integration
    'https://github.com/lewis6991/gitsigns.nvim',

    -- toggle floating term
    'https://github.com/akinsho/toggleterm.nvim',

    -- color theme / scheme
    { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },

    -- comment helper
    'https://github.com/tpope/vim-commentary',

    -- fuzzy finder
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',

    'https://github.com/iamcco/markdown-preview.nvim',

    -- status line
    'https://github.com/nvim-lualine/lualine.nvim',

    -- file explorer
    'https://github.com/nvim-tree/nvim-tree.lua',

    -- icons for everything, file explorer, tabs, statusline
    'https://github.com/nvim-tree/nvim-web-devicons',

    -- automatically add "([ pairs if first one is typed
    'https://github.com/jiangmiao/auto-pairs',

    -- syntax highlighting and parser
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
})

require("todo-comments").setup()

require("telescope").setup()

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

require('nvim-web-devicons').setup()

require("catppuccin").setup({
    transparent_background = false,
})
vim.cmd.colorscheme "catppuccin-latte"
