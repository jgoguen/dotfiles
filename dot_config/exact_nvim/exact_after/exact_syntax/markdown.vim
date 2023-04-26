" Do not edit this file directly! It is managed by chezmoi.

" Block math. Look for "$$[anything]$$"
syn region math start=/\$\$/ end=/\$\$/

" inline math. Look for "$[not $][anything]$"
syn match math_block '\$[^$].\{-}\$'

" Liquid single line. Look for "{%[anything]%}"
syn match liquid '{%.*%}'

" Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
syn region highlight_block start='{% highlight .*%}' end='{%.*%}'

" Fenced code blocks, used in GitHub Flavored Markdown (GFM)
syn region highlight_block start='```' end='```'

" Actually highlight those regions.
highlight link math Statement
highlight link liquid Statement
highlight link highlight_block Function
highlight link math_block Function
