vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
})

_G.floating_options = {
    focusable = true,
    focus = false,
    max_height = 50,
    max_width = 100,
}

vim.api.nvim_create_autocmd({ "BufWritePre", nil }, {
    callback = function()
        if vim.lsp.buf_is_attached() then
            vim.lsp.buf.format()
        end
    end,
})

vim.lsp.buf.code_action = (function(orig)
    return function(opts)
        opts = opts or {}
        opts.filter = function(action)
            if not action then return false end
            -- Ignore gopls "Browse" actions
            if action.title and action.title:match("Browse gopls") then
                return false
            end
            return true
        end
        return orig(opts)
    end
end)(vim.lsp.buf.code_action)

vim.filetype.add({
    extension = {
        scm   = "scheme",
        sls   = "scheme",
        js    = "javascript",
        ts    = "typescript",
        vue   = "vue",
        tengo = "tengo",
    },
})

local lsps = {
    { "rust_analyzer" },
    { "gopls" },
    { "lua_ls" },
    {
        "clangd",
        {
            init_options = {
                fallbackFlags = { '--std=c23', '-xc' }
            },
        }
    },
    {
        "scheme-rs",
        {
            cmd = {
                "/home/teo/programming/scheme-rs/target/debug/scheme-rs",
                "--lsp",
                "--dangerously-allow-macro-expansion-in-lsp",
            },
            filetypes = { "scheme" }
        }
    },
    {
        "tengo",
        {
            cmd = { "tengo-lsp" },
            filetypes = { "tengo" }
        },
    },
    -- {
    --     "sqleibniz",
    --     {
    --         cmd = { '/usr/bin/sqleibniz', '--lsp' },
    --         filetypes = { "sql" },
    --         root_markers = { "leibniz.lua" }
    --     }
    -- },
    -- {
    --     "rust-lsp-example",
    --     {
    --         cmd = { '/usr/local/bin/rust-lsp-example', '--lsp' },
    --         filetypes = { "lisp" },
    --     }
    -- },
}

-- see: https://neovim.io/doc/user/news-0.11.html#_lsp
for _, lsp in pairs(lsps) do
    local name, config = lsp[1], lsp[2]
    vim.lsp.enable(name)
    if config then
        vim.lsp.config(name, config)
    end
end
