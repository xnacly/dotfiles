if vim.b.current_syntax then
  return
end

-- Comments
vim.cmd [[
  syntax match gardenComment "#.*$"
]]

-- Strings: "..."
vim.cmd [[
  syntax region gardenString start=+"+ skip=+\\."+ end=+"+
]]

-- Quoted identifiers: 'no-spaces
vim.cmd [[
  syntax match gardenQuoted "'[^ \t\r\n]\+"
]]

-- Numbers
vim.cmd [[
  syntax match gardenNumber "\v\d+\.\d+"
  syntax match gardenNumber "\v\d+"
]]

-- Keywords
vim.cmd [[
  syntax keyword gardenKeyword var fn match for std
  syntax keyword gardenBoolean true false
]]

-- Identifiers
vim.cmd [[
  syntax match gardenIdentifier "\v[A-Za-z_][A-Za-z0-9_]*"
]]

-- Namespaced paths: foo::bar::baz
vim.cmd [[
  syntax match gardenNamespace "\v([A-Za-z_][A-Za-z0-9_]*::)+[A-Za-z_][A-Za-z0-9_]*"
]]

-- Operators
vim.cmd [[
  syntax match gardenOperator "::"
  syntax match gardenOperator "[+\-*/=<>!]"
]]

-- Delimiters
vim.cmd [[
  syntax match gardenQuoted "'[^ \\t\\r\\n]\+"
]]

-- Highlight links
vim.cmd [[
  highlight link gardenComment Comment
  highlight link gardenString String
  highlight link gardenQuoted String
  highlight link gardenNumber Number
  highlight link gardenKeyword Keyword
  highlight link gardenBoolean Boolean
  highlight link gardenIdentifier Identifier
  highlight link gardenNamespace Namespace
  highlight link gardenOperator Operator
  highlight link gardenDelimiter Delimiter
]]

vim.b.current_syntax = "garden"
