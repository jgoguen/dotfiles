" vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
" vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:
" Do not edit this file directly! It is managed by chezmoi.
setlocal noexpandtab
setlocal foldmethod=syntax

compiler go

nnoremap <Leader>gb <Plug>(go-build)
nnoremap <Leader>tt <Plug>(go-test)
nnoremap <Leader>gr <Plug>(go-run)
