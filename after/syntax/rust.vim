if exists("b:coc_additional_keywords")
    finish
endif

syntax keyword rustKeyword as
" ctermfg=128 guifg=Green
highlight link rustKeyword Keyword

let b:current_syntax = "rust"
