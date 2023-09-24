function remove_numbers()
  vim.wo.number = not vim.wo.number
  vim.wo.relativenumber = not vim.wo.relativenumber
end

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('t', '<c-k>', '<c-\\><c-n>:wincmd k<CR>')
vim.keymap.set('t', '<c-j>', '<c-\\><c-n>:wincmd j<CR>')
vim.keymap.set('t', '<c-h>', '<c-\\><c-n>:wincmd h<CR>')
vim.keymap.set('t', '<c-l>', '<c-\\><c-n>:wincmd l<CR>')

-- Spawn terminal at bottom of screen
vim.keymap.set('n', '<leader>;', ':belowright split | term<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
-- vim.keymap.set('n', '<leader>nln', remove_numbers)

vim.keymap.set('n', '<leader><CR>', ":so %<CR>")
vim.keymap.set('n', '<leader>d', ':lua vim.diagnostic.open_float()<CR>')


-- vim.keymap.set('n', '<A-k>', ':m -2<CR>')
-- vim.keymap.set('n', '<A-j>', ':m +1<CR>')

