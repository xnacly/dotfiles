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

vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

vim.keymap.set('i', '<C-Space>', function()
    vim.lsp.completion.get()
end)

vim.keymap.set('i', '<Tab>', function()
    if vim.fn.pumvisible() == 0 then
        return '<Tab>'
    end

    return vim.fn.complete_info({ 'selected' }).selected == -1 and '<C-n><C-y>' or '<C-y>'
end, { expr = true })


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
        "tengo",
        {
            cmd = { "tengo-lsp" },
            filetypes = { "tengo" }
        },
    },
    {
        "purple-garden",
        {
            cmd = { '/home/teo/programming/purple-garden/target/debug/purple-garden', 'lsp' },
            filetypes = { "garden" },
        }
    },
    {
        "sqleibniz",
        {
            cmd = { '/usr/bin/sqleibniz', '--lsp' },
            filetypes = { "sql" },
            root_markers = { "leibniz.lua" }
        }
    },
}

-- see: https://neovim.io/doc/user/news-0.11.html#_lsp
for _, lsp in pairs(lsps) do
    local name, config = lsp[1], lsp[2]
    vim.lsp.enable(name)
    if config then
        vim.lsp.config(name, config)
    end
end
