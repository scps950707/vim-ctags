" =============================================================================
" Author:         scps950707
" Email:          scps950707@gmail.com
" Created:        2016-06-30 02:46
" Last Modified:  2016-06-30 02:46
" Filename:       ctags.vim
" =============================================================================

if exists('g:loaded_ctags') || v:version < 700
    finish
endif
let g:loaded_ctags=1

let s:save_cpo = &cpo
set cpo&vim


command! -nargs=0 CtagsFullDepend call ctags#FullDepend()
command! -nargs=0 CtagsFileIncluded call ctags#FileIncluded()


let &cpo = s:save_cpo
unlet s:save_cpo
