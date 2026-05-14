
# --- ZSHRC --- #

# if $DEBUG_ZSH_PROF=1, load zprof
if (( ${+DEBUG_ZSH_PERF} )); then
  zmodload zsh/zprof
fi
# example command: DEBUG_ZSH_PROF=1 zsh -i

: "${ZSH_ROOT:=$ZDOTDIR/.zsh}"

_zsh_compile_if_needed() {
  local src=$1 dst="${1}.zwc"
  [[ -n $src && -r $src ]] || return 1
  if [[ ! -f $dst || $src -nt $dst ]]; then
    # compile silently
    zcompile "$src" 2>/dev/null
  fi
}


load_zsh_dir() {
  local dir=$1 file
  [[ -d $dir && -r $dir ]] || return 0
  for file in "$dir"/*.zsh(N); do
    [[ -r $file ]] || continue
    _zsh_compile_if_needed "$file"
    source "$file"
  done
}

load_zsh_functions() {
  local fn_dir=${1}/functions
  [[ -d $fn_dir ]] || return 0

  fpath=("$fn_dir" $fpath)
  autoload -U "$fn_dir"/*(:tN)
}

load_zsh_config() {
  if [[ -d $ZSH_ROOT ]]; then
      for dir in core tools third-party/zsh-autosuggestions third-party/zsh-syntax-highlighting; do
      load_zsh_dir "$ZSH_ROOT/$dir"
    done
    load_zsh_functions "$ZSH_ROOT"
  else
    printf 'ZSH_ROOT not found at %s\n' "$ZSH_ROOT" >&2
  fi

# for zsh autocomplete
# bindkey              '^I'         menu-complete
# bindkey "$terminfo[kcbt]" reverse-menu-complete

  # private configs
  [[ -f $HOME/.zshrc.private ]] && source "$HOME/.zshrc.private"
}

load_zsh_config

if (( ${+DEBUG_ZSH_PERF} )); then
  zprof
fi
