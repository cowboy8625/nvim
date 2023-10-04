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
vim.cmd [[ autocmd BufRead,BufNewFile *.a set filetype=a ]]
vim.cmd [[ autocmd BufRead,BufNewFile *.tera set filetype=html ]]

-- hide tmux bar when in vim
-- vim.cmd [[ autocmd VimEnter,VimLeave * silent !tmux set status ]]



-- think its supposed to turn the terminal opacity to the
-- default terminals opacity.
vim.cmd [[ au ColorScheme * hi Normal ctermbg=none guibg=none ]]
vim.cmd [[ au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red ]]

--Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- remove command bar
vim.opt.cmdheight = 0

vim.diagnostic.config({
  float = { border = 'rounded' }
})

-- neovide
if vim.g.neovide then
  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 0.8
  vim.g.transparency = 0.8
  vim.g.neovide_background_color = "#0f1117" .. alpha()
  vim.g.guifont = "SourceCodePro Nerd Font:h24"
  vim.g.neovide_scale_factor = 1.2
  vim.opt.linespace = 0
end
