" Do not edit this file directly! It is managed by chezmoi.

setlocal foldmethod=indent
setlocal includeexpr=import#PythonImport(v:fname)
setlocal nospell

if exists(':Black')
	augroup ftpython
		autocmd!
		autocmd BufWritePre <buffer> execute ':Black'
	augroup END
endif
