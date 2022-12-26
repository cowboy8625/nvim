vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- enable lua filetype
vim.g.do_filetype_lua = 1;

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.cmd [[ set noswapfile ]]

-- not sure how to do this in lua yet.
vim.cmd [[ autocmd BufRead,BufNewFile *.snow set filetype=snow ]]
vim.cmd [[ autocmd BufRead,BufNewFile *.snack set filetype=snack ]]
vim.cmd [[ set listchars=tab:>~,nbsp:_,trail:● ]]

-- think its supposed to turn the terminal opacity to the
-- default terminals opacity.
vim.cmd [[ au ColorScheme * hi Normal ctermbg=none guibg=none ]]
vim.cmd [[ au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red ]]

--Line numbers
vim.wo.number = true
vim.wo.relativenumber = true
