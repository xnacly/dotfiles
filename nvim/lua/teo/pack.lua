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

local function wal_latte_colors()
    local fallback = {
        base = "#e8e3d6",
        mantle = "#ddd7c8",
        crust = "#d2caba",
        surface0 = "#c8bfad",
        surface1 = "#bdb3a0",
        surface2 = "#b2a792",
        overlay0 = "#958b7b",
        overlay1 = "#877d70",
        overlay2 = "#796f64",
    }

    local path = vim.fn.expand("~/.config/nvim/wal-colors.json")
    local ok_read, lines = pcall(vim.fn.readfile, path)
    if not ok_read or #lines == 0 then
        return fallback
    end

    local ok, wal = pcall(vim.json.decode, table.concat(lines, "\n"))
    if not ok or not wal.special or not wal.colors then
        return fallback
    end

    return {
        base = wal.special.background or fallback.base,
        mantle = wal.colors.color0 or fallback.mantle,
        crust = wal.colors.color0 or fallback.crust,
        surface0 = wal.colors.color0 or fallback.surface0,
        surface1 = wal.colors.color7 or fallback.surface1,
        surface2 = wal.colors.color8 or fallback.surface2,
        overlay0 = wal.colors.color8 or fallback.overlay0,
        overlay1 = wal.colors.color8 or fallback.overlay1,
        overlay2 = wal.colors.color8 or fallback.overlay2,
        text = wal.special.foreground,
        subtext1 = wal.colors.color15,
        subtext0 = wal.colors.color7,
        red = wal.colors.color1,
        maroon = wal.colors.color9,
        peach = wal.colors.color3,
        yellow = wal.colors.color11,
        green = wal.colors.color2,
        teal = wal.colors.color6,
        sky = wal.colors.color14,
        sapphire = wal.colors.color6,
        blue = wal.colors.color4,
        lavender = wal.colors.color12,
        mauve = wal.colors.color5,
        pink = wal.colors.color13,
        flamingo = wal.colors.color13,
        rosewater = wal.colors.color15,
    }
end

require("catppuccin").setup({
    transparent_background = false,
    color_overrides = {
        latte = wal_latte_colors(),
    },
})
vim.cmd.colorscheme "catppuccin-latte"
