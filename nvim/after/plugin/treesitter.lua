require'nvim-treesitter'.setup {
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  init = function()
  local ensureInstalled = {
    'lua', 'python', 'typescript',
    -- ... your parsers
  }
  local alreadyInstalled = require('nvim-treesitter.config').get_installed()
  local parsersToInstall = vim.iter(ensureInstalled)
    :filter(function(parser)
      return not vim.tbl_contains(alreadyInstalled, parser)
    end)
    :totable()

  require('nvim-treesitter').install(parsersToInstall)
      vim.api.nvim_create_autocmd('FileType', { 
        callback = function() 
          -- Enable treesitter highlighting and disable regex syntax
          pcall(vim.treesitter.start) 
          -- Enable treesitter-based indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" 
        end, 
      }) 
  end
}
