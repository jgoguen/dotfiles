" Do not edit this file directly! It is managed by chezmoi.

setlocal noautoindent
setlocal nolinebreak
setlocal spell
setlocal textwidth=0

augroup hgcommit
	autocmd!
	autocmd BufEnter *.commit.hg.txt call setpos('.', [0, 1, 1, 0])
augroup END
