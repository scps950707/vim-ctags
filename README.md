# vim-ctags
plugin for generating Ctags for vim omnicomplete in current directory recursively


##script for generate project tags


###Full Dependency:
advantage:gcc complier will completely find all dependency as a list which ctags will use it to create project tag
defect:tags to large,so much deep or useless information

command:
```sh
find . -regex '\..*[ch]p*p*$' | xargs gcc -M | sed 's/[\\ ]/\n/g' | sed '/^$/d;/\.o:[ \t]*$/d' | sort -u | ctags -L - --sort=yes --c-kinds=defgpstux --fields=+iaS --extra=+q -I __attribute__,__attribute_malloc__,__attribute_pure__,__wur,__THROW
```


###Only Included headers:
advantage:use sed to find all include headers in the current project
defect:maybe some informations are ignored

command:
```sh
find . -regex '\..*[ch]p*p*$' | xargs sed -n 's/.*\(#include.*[>"]\).*/\1/p' | sed 's/#include//g;s/[>< ]//g' | sort -u > myheaders
find . -regex '\..*[ch]p*p*$' | xargs gcc -M | sed 's/[\\ ]/\n/g' | sed '/^$/d;/\.o:[ \t]*$/d' | grep -f myheaders | sort -u | ctags -L - --sort=yes --c-kinds=defgpstux --fields=+iaS --extra=+q -I __attribute__,__attribute_malloc__,__attribute_pure__,__wur,__THROW
rm myheaders
```


##key mapping for functions above
```c++
map <F10> :CtagsFileIncluded<CR>
map <C-F10> :CtagsFullDepend<CR>
```


##Reference
- [ctags](http://ctags.sourceforge.net/)
- [Generate Ctags Files for C/C++ Source Files and All of Their Included Header Files](https://www.topbug.net/blog/2012/03/17/generate-ctags-files-for-c-slash-c-plus-plus-source-files-and-all-of-their-included-header-files/)
- [ctags ignore lists for libc6, libstdc++ and boost](http://stackoverflow.com/questions/5626188/ctags-ignore-lists-for-libc6-libstdc-and-boost)
