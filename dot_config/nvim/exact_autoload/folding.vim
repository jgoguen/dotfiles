" vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
" vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:
" Do not edit this file directly! It is managed by chezmoi.

" This defines the text to be shown for a folded block of text
function! folding#CustomFoldText()
	" Get first non-blank line
	let fs = v:foldstart
	while getline(fs) =~? '^\s*$' | let fs = nextnonblank(fs + 1)
	endwhile

	if fs > v:foldend
		let line = getline(v:foldstart)
	else
		let line = getline(fs)
	endif

	let indentation = substitute(line, '\S.*', '', 'g')
	let linetxt = substitute(line, '^\s*', '', 1)
	let linetxt = substitute(linetxt, split(&foldmarker, ',')[0], '', 'g')

	let foldSize = 1 + v:foldend - v:foldstart
	return indentation . '|' . linetxt . ' (' . foldSize . ' lines)'
endfunction

function! folding#Fold_Includes(ln)
	let cur_line = getline(a:ln)
	let prev_line = getline(a:ln - 1)

	" skip empty lines
	let empty_regex = '^\s*$'
	if cur_line =~ empty_regex
		return -1
	endif

	if cur_line[:8] ==# '#include '
		return (prev_line[:8] ==# '#include ' ||
					\ prev_line =~ empty_regex) ? 1 : '>1'
	endif

	if cur_line[:9] ==# 'namespace '
		return prev_line[:9] ==# 'namespace ' ? 1 : '>1'
	endif

	let end_ns_regex = '^}}*\s*//\s*namespace'
	if cur_line =~ end_ns_regex
		return prev_line =~ end_ns_regex ? 1 : '>1'
	endif

	return 0
endfunction

