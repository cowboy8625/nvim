-- set makeprg=sbcl\ --script\ %
vim.cmd([[ set makeprg=zig ]])
-- vim.api.nvim_set_var('makeprg', 'sbcl --script %')
vim.keymap.set("n", ";;", ":make build run<CR>")
vim.keymap.set("n", ";b", ":make build<CR>")
vim.keymap.set("n", ";rf", ":make run %<CR>")
