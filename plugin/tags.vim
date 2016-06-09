function! TagFullDepend()
  let command = ''
  let command = '
        \ls -R
        \| grep ''\..*[ch]p*p*$''
        \| xargs gcc -M
        \| sed ''s/[\\ ]/\n/g''
        \| sed ''/^$/d;/\.o:[ \t]*$/d''
        \| sort -u
        \| ctags -L - --sort=yes --c-kinds=defgpstux --fields=+iaS --extra=+q
        \ -I __attribute__,__attribute_malloc__,__attribute_pure__,__wur,__THROW '
  execute '!'.command
endfunction
" map <C-F10> :<C-u>call TagFullDepend()<CR>
command! -nargs=0 TagFullDepend call TagFullDepend()

function! TagFileIncluded()
  let find_include = ''
  let find_include = '
        \ls -R
        \| grep ''\..*[ch]p*p*$''
        \| xargs sed -n ''/include/p''
        \| sed ''s/\#include//g;s/[>< ]//g''
        \| sort -u
        \ > myincludeheaders '
  let generate_ctags = ''
  let generate_ctags = '
        \ls -R
        \| grep ''\..*[ch]p*p*$''
        \| xargs gcc -M
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
" map <F10> :<C-u>call TagFileIncluded()<CR>
command! -nargs=0 TagFileIncluded call TagFileIncluded()