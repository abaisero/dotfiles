"" fold methods
function! VimFold(lnum)
  if getline(a:lnum) =~? '\v^\s*$'
    return '-1'
  elseif getline(a:lnum) =~? '\v^""\s*$'
    return 's1'
  elseif getline(a:lnum) =~? '\v^""'
    return 'a1'
  endif
  return '='
endfunction
"" fold methods
"" options
setlocal foldexpr=VimFold(v:lnum)
setlocal foldmethod=expr
setlocal foldcolumn=1
"" options
