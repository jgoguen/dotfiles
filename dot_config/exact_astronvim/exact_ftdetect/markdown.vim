" vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
" vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:
" Do not edit this file directly! It is managed by chezmoi.

augroup detectmd
	autocmd!

	autocmd BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,*.md set filetype=pandoc.markdown
augroup END
