__fzf_history_widget() {
  local selected
  selected=$(history | awk '{ lines[NR] = $0 } END { for (i = NR; i > 0; i--) print lines[i] }' \
    | fzf --exact --tiebreak=index --no-sort --reverse --height=40% \
      --bind 'ctrl-r:toggle-sort' --expect=ctrl-e \
      --query="$READLINE_LINE")

  local key command
  key=$(head -n1 <<< "$selected")
  command=$(tail -n1 <<< "$selected" | sed -E 's/ *[0-9]+\*? //')

  if [[ -n "$command" ]]; then
    READLINE_LINE="$command"
    READLINE_POINT=${#READLINE_LINE}
    if [[ "$key" != "ctrl-e" ]]; then
      echo "$READLINE_LINE"
      eval "$READLINE_LINE"
      READLINE_LINE=""
      READLINE_POINT=0
    fi
  fi
}
