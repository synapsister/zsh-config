# Shared helper functions for zsh configuration
#
# Common utilities used throughout the zsh config. Loaded early (05-)
# so all other config files can use these helpers.

# Command existence check
# Usage: has git && git status
# Usage: has git fzf jq && echo "all installed"
has() {
  local cmd
  for cmd in "$@"; do
    (( $+commands[$cmd] )) || return 1
  done
}


# Clipboard operations
# Usage: echo "text" | clip
clip() {
  if has wl-copy; then
    wl-copy
  elif has xclip; then
    xclip -selection clipboard
  else
    cat
    echo 'No clipboard tool found, printed to stdout.' >&2
    return 1
  fi
}

# Returns the clipboard command for use in aliases
# Usage: alias -g C="| $(_clip_cmd)"
_clip_cmd() {
  if has wl-copy; then
    echo "wl-copy"
  elif has xclip; then
    echo "xclip -selection clipboard"
  else
    echo "cat"
  fi
}
