__fzf_history_widget() {
  stty sane 2>/dev/null
  local selected key command
  selected=$(history | awk '{ lines[NR] = $0 } END { for (i = NR; i > 0; i--) print lines[i] }' \
    | fzf --exact --tiebreak=index --no-sort --reverse --height=40% \
      --bind 'ctrl-r:toggle-sort' --expect=ctrl-e \
      --query="$READLINE_LINE")
  key=$(head -n1 <<< "$selected")
  command=$(tail -n1 <<< "$selected" | sed -E 's/ *[0-9]+\*? //')
  if [[ -n "$command" ]]; then
    READLINE_LINE="$command"
    READLINE_POINT=${#READLINE_LINE}
    if [[ "$key" != "ctrl-e" ]]; then
      echo "$READLINE_LINE"
      stty sane 2>/dev/null
      eval "$READLINE_LINE"
      READLINE_LINE=""
      READLINE_POINT=0
      stty sane 2>/dev/null
    fi
  fi
}

bind -x '"\C-r": __fzf_history_widget'
