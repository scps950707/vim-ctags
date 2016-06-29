" =============================================================================
" Author:         scps950707
" Email:          scps950707@gmail.com
" Created:        2016-06-30 02:47
" Last Modified:  2016-06-30 02:47
" Filename:       ctags.vim
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim


function! ctags#FullDepend()
    let command = '
        \find . -regex ''.*\.[ch]p*p*$''
        \| xargs g++ -M
        \| sed ''s/[\\ ]/\n/g''
        \| sed ''/^$/d;/\.o:[ \t]*$/d''
        \| sort -u
        \| ctags -L - --sort=yes --c-kinds=defgpstux --fields=+iaS --extra=+q
        \ -I __attribute__,__attribute_malloc__,__attribute_pure__,__wur,__THROW '
    execute '!'.command
endfunction

function! ctags#FileIncluded()
    let find_include = '
        \find . -regex ''.*\.[ch]p*p*$''
        \| xargs sed -n ''s/.*\(\#include.*[>"]\).*/\1/p''
        \| sed ''s/\#include//g;s/[>< ]//g''
        \| sort -u
        \ > myincludeheaders '
    let generate_ctags = '
        \find . -regex ''.*\.[ch]p*p*$''
        \| xargs g++ -M
        \| sed ''s/[\\ ]/\n/g''
        \| sed ''/^$/d;/\.o:[ \t]*$/d''
        \| grep -f myincludeheaders
        \| sort -u
        \| ctags -L - --sort=yes --c-kinds=defgpstux --fields=+iaS --extra=+q
        \ -I __attribute__,__attribute_malloc__,__attribute_pure__,__wur,__THROW '
    let remove_tmp = 'rm myincludeheaders'
    execute '!'.find_include.' && '.generate_ctags.' && '.remove_tmp
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
