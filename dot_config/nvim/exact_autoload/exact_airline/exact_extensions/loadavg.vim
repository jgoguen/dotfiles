" vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
" vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:

let s:space = g:airline_symbols.space
let s:alt_sep = g:airline_right_alt_sep

function! airline#extensions#loadavg#init(ext)
	"Add a new part for the load average
	call airline#parts#define_raw('loadavg', '%{airline#extensions#loadavg#load()}')

	" Funcref to call before the status line is updated
	call a:ext.add_statusline_func('airline#extensions#loadavg#apply')
endfunction

function! airline#extensions#loadavg#apply(...)
	let w:airline_section_z = get(w:,'airline_section_z', g:airline_section_z)
	let w:airline_section_z .= s:space . s:alt_sep . s:space . '%{airline#extensions#loadavg#load()}'
endfunction

function! airline#extensions#loadavg#load()
	let loadavg = []

	if has('mac')
		let uptime = substitute(system('uptime'), '\n', '', 'g')
		let raw_load = split(uptime, ':')[-1]
		let loadavg = split(raw_load, ' ')
	elseif has('unix')
		let uptime = substitute(system('uptime'), '\n', '', 'g')
		let raw_load = substitute(uptime[-1], ' ', '', 'g')
		let loadavg = split(raw_load, ',')
	endif

	return join(loadavg, '/')
endfunction
