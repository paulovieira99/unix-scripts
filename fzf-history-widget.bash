# Histórico gigante
HISTSIZE=100000
HISTFILESIZE=100000
HISTFILE=~/.bash_history

# Opções avançadas
shopt -s histappend       # não sobrescrever o arquivo
shopt -s cmdhist          # agrupa multiline
shopt -s lithist          # salva com formatação literal

# Evitar duplicados
export HISTCONTROL=ignoredups:erasedups

# Salva imediatamente
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Timestamp nos comandos
export HISTTIMEFORMAT='%F %T '

fzf_history() {
  local selected
  selected=$(history | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]+([0-9]{4}-[0-9]{2}-[0-9]{2}[[:space:]][0-9]{2}:[0-9]{2}:[0-9]{2}[[:space:]]+)?//' \
    | awk 'NF' \
    | sort -u \
    | fzf --height=50% --layout=reverse --border \
          --prompt="history> " \
          --preview 'echo {}' \
          --preview-window=up:3:wrap \
          --header 'ENTER: inserir na linha | ESC: cancelar' )

  if [[ -n "$selected" ]]; then
    READLINE_LINE="$selected"
    READLINE_POINT=${#selected}
  fi
}

# bind Ctrl+R
bind -x '"\C-r": fzf_history'

