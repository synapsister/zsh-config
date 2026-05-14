has fzf || return

source <(fzf --zsh)

export FZF_DEFAULT_OPTS="
  --reverse
  --pointer=''
  --prompt=
  --highlight-line
  --no-separator
  --no-scrollbar
  --info=inline-right
  --color=bg:-1,fg:-1,bg+:#FF9999,fg+:#000000,hl:#cc5500,hl+:#cc5500,pointer:-1,prompt:-1,info:-1,gutter:-1"
