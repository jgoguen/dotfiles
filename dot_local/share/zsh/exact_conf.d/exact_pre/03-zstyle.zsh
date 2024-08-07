# vim: set filetype=zsh:
# Do not edit this file directly! It is managed by chezmoi.

zstyle ':completion:*' ambiguous true
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand_alias _expand _complete _correct _approximate _ignored
zstyle ':completion:*' completions true
zstyle ':completion:*' expand prefix suffix

# format all messages not formatted in bold prefixed with ----
zstyle ':completion:*' format '%B---- %d%b'
zstyle ':completion:*' glob true
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd directory
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' keep-prefix false
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %l: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt 'Corrections (%e errors)'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' special-dirs ..
zstyle ':completion:*' substitute 1
zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# Don't complete the same twice
zstyle ':completion:*:complete:-command-::*' ignore-line yes

# Don't complete backup files as commands.
zstyle ':completion:*:complete:-command-::*' ignored-patterns '*\~'
zstyle ':completion:*:complete:dpkg:option--listfiles-1:*' packageset installed
zstyle ':completion:*:complete:dpkg:option--status-1:*' packageset avail

# format descriptions (notice the vt100 escapes)
zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
zstyle ':completion:*:sudo::' environ PATH="/opt/homebrew/bin:/usr/local/sbin:/usr/local/bin:/sbin:/usr/sbin:/bin:/usr/bin:$PATH" HOME="${HOME}"
# format in bold red error messages
zstyle ':completion:*:warnings' format "%B$fg[red]%}---- no match for: $fg[white]%d%b"

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

if [ ! -d "${ZSH_CACHE_DIR}" ]; then
	mkdir -p "${ZSH_CACHE_DIR}"
fi
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${ZSH_CACHE_DIR}"

zstyle :compinstall filename "${USER_ZSH}/zcompdump"
