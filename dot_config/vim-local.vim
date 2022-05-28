" vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
" vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:

let s:local_vim_lua = printf('%s/vim-local.lua', g:xdg_config_home)
if filereadable(s:local_vim_lua)
	execute printf('source %s', s:local_vim_lua)
endif
