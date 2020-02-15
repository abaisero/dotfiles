function TODO_inc()
  :s/XXX/DONE/e
  :s/TODO/XXX/e
endfunction

function TODO_dec()
  :s/XXX/TODO/e
  :s/DONE/XXX/e
endfunction

nnoremap <leader>+ :call TODO_inc()<cr>
nnoremap <leader>- :call TODO_dec()<cr>
vnoremap <leader>+ :call TODO_inc()<cr>
vnoremap <leader>- :call TODO_dec()<cr>
