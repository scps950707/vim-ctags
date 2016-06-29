function! TagFullDepend()
    let command = ''
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
command! -nargs=0 CtagsFullDepend call TagFullDepend()

function! TagFileIncluded()
    let find_include = ''
    let find_include = '
        \find . -regex ''.*\.[ch]p*p*$''
        \| xargs sed -n ''s/.*\(\#include.*[>"]\).*/\1/p''
        \| sed ''s/\#include//g;s/[>< ]//g''
        \| sort -u
        \ > myincludeheaders '
    let generate_ctags = ''
    let generate_ctags = '
        \find . -regex ''.*\.[ch]p*p*$''
        \| xargs g++ -M
        \| sed ''s/[\\ ]/\n/g''
        \| sed ''/^$/d;/\.o:[ \t]*$/d''
        \| grep -f myincludeheaders
        \| sort -u
        \| ctags -L - --sort=yes --c-kinds=defgpstux --fields=+iaS --extra=+q
        \ -I __attribute__,__attribute_malloc__,__attribute_pure__,__wur,__THROW '
    let remove_tmp = ''
    let remove_tmp = 'rm myincludeheaders'
    execute '!'.find_include.' && '.generate_ctags.' && '.remove_tmp
endfunction
command! -nargs=0 CtagsFileIncluded call TagFileIncluded()
