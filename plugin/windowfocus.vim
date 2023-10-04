" func! UnsetAllWindowRelative()
"   for nr in range(1, winnr("$"))
"     if nr != winnr()
"       call setwinvar(nr, "&relativenumber", 0)
"     endif
"   endfor
" endfunc
" 
" func! OnlyThisWindowRelative()
"   for nr in range(1, winnr("$"))
"     call setwinvar(nr, "&relativenumber", nr == winnr())
"   endfor
" endfunc
" 
" augroup numbertoggle
"   autocmd!
"   autocmd VimEnter,WinEnter,WinLeave,WinNew * call OnlyThisWindowRelative()
" augroup END
