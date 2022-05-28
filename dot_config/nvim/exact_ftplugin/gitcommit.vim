" vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
" vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:
" Do not edit this file directly! It is managed by chezmoi.
setlocal noautoindent
setlocal nolinebreak
setlocal spell
setlocal textwidth=0

augroup gitcommit
	autocmd!
	autocmd BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END
