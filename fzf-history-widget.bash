export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend

if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
elif [ -f /usr/share/fzf/key-bindings.bash ]; then
    source /usr/share/fzf/key-bindings.bash
elif [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
elif [ -f /opt/homebrew/opt/fzf/shell/key-bindings.bash ]; then
    # Para macOS com Homebrew
    source /opt/homebrew/opt/fzf/shell/key-bindings.bash
fi

# Customiza as opções do FZF
export FZF_CTRL_R_OPTS="
  --preview 'echo {}'
  --preview-window down:3:wrap
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --header 'Enter: inserir | Ctrl-Y: copiar'
  --border
  --height 40%"
