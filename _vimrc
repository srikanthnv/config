" Choose a windows friendly color scheme
colorscheme elflord

" Choose a windows friendly font
set guifont=Courier\ New:h11:cANSI

" Enable syntax highlighting
syntax on

" Enable automatic indentation
set autoindent

" Disable wordwrap for long lines
set nowrap

" Force line breaks in long lines that you enter
set wrapmargin=4
set textwidth=70

" Highlight long lines
highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
1match OverLength /\%81v.\+/

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=darkred ctermfg=white guibg=#FFD9D9
2match ExtraWhitespace /\s\+$\| \+\ze\t/

" Highlight unneeded blank lines
highlight BlankLines ctermbg=darkred ctermfg=white guibg=#FFD9D9
3match BlankLines /^$\n\{2,}/

" Highlight search results
set hlsearch

" Show line numbers
set nu
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Center the search result when searching for the next or previous match
map N Nzz
map n nzz

" hex/dec conversion functions
command! -nargs=? -range Dec2hex call s:Dec2hex(<line1>, <line2>, '<args>')
function! s:Dec2hex(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    else
      let cmd = 's/\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No decimal number found'
    endtry
  else
    echo printf('%x', a:arg + 0)
  endif
endfunction

command! -nargs=? -range Hex2dec call s:Hex2dec(<line1>, <line2>, '<args>')
function! s:Hex2dec(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V0x\x\+/\=submatch(0)+0/g'
    else
      let cmd = 's/0x\x\+/\=submatch(0)+0/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No hex number starting "0x" found'
    endtry
  else
    echo (a:arg =~? '^0x') ? a:arg + 0 : ('0x'.a:arg) + 0
  endif
endfunction

set backspace=2
set backspace=indent,eol,start

