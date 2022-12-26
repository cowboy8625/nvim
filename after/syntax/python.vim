if exists("b:coc_additional_keywords")
    finish
endif

syntax keyword pythonKeyword self match case
" ctermfg=128 guifg=Green
highlight link pythonKeyword Keyword

let b:current_syntax = "python"
