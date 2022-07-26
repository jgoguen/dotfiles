" vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
" vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:
" Do not edit this file directly! It is managed by chezmoi.

augroup detectruby
	autocmd!
	autocmd BufNewFile,BufRead */cookbooks/*.rb set filetype=ruby.eruby.chef
	autocmd BufNewFile,BufRead */cookbooks/*.erb set filetype=ruby.erb.chef
	autocmd BufNewFile,BufRead *.rb setfiletype ruby
augroup END
