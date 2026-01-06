lsa() {
  eza -la --icons --git "$@"
}

alias cp='rsync -ahP'
alias cd='z'
alias tcget='termux-clipboard-get'
alias tcset='termux-clipboard-set'

# pnpm
export PNPM_HOME="/data/data/com.termux/files/home/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export EDITOR=nvim

# aliases

# custom functions
rcpp() {
  # Ensure GNU time is used (install with: pkg install time)
  local time_cmd="command time"

  if [[ "$1" == "--no" ]]; then
    shift
    local f="$1"
    local bin="./${f%.cpp}"
    g++ "$f" -o "$bin" && {
      # Redirect bin stdout to tty, capture time stderr into var
      local stats=$($time_cmd -f "%e %M" "$bin" 2>&1 >/dev/tty)
      local r_time=$(echo "$stats" | awk '{print $1 * 1000}')
      local r_mem=$(echo "$stats" | awk '{print $2}')

      # FIX: Added variables to printf
      printf "\n\nTime: %s ms | Memory: %s KB\n" "$r_time" "$r_mem"
    }
  else
    local f="$1"
    local in="${2:-input.txt}"
    local bin="./${f%.cpp}"
    g++ "$f" -o "$bin" && {
      local stats=$($time_cmd -f "%e %M" "$bin" <"$in" 2>&1 >/dev/tty)
      local r_time=$(echo "$stats" | awk '{print $1 * 1000}')
      local r_mem=$(echo "$stats" | awk '{print $2}')
      printf "\n\nTime: %s ms | Memory: %s KB\n" "$r_time" "$r_mem"
    }
  fi
}

rncpp() {
  rcpp --no "$@"
}

ff() {
  fzf \
    --preview '[[ -f {} ]] && bat --style=numbers --color=always --paging=never --line-range :300 {}' \
    --preview-window=up:50% \
    --bind 'ctrl-d:execute(
        read -p "Delete {}? (y/n): " confirm && 
        [[ $confirm == [yY] ]] && rm -v {} && 
        || echo "Aborted"
    )' \
    --bind 'ctrl-e:execute(
        $EDITOR {}
    )' \
    --bind 'enter:execute(
        $EDITOR {}
    )+accept' \
    "$@"
}

ffr() {
  rg --line-number --no-heading --color=always "" |
    fzf --ansi \
      --preview 'bat --color=always --paging=never {1} --highlight-line {2}' \
      --preview-window=up:60% \
      --delimiter ':' \
      --bind 'change:reload:rg --line-number --no-heading --color=always {q} || true'
}

eval -- "$(/data/data/com.termux/files/usr/bin/starship init bash --print-full-init)"
eval "$(zoxide init bash)"

# pyvenv source shortcut
pysrc() {
  local venv_path=".venv"

  if [[ -n "$1" ]]; then
    venv_path = "$1"
  fi

  if [[ -f "$venv_path/bin/activate" ]]; then
    source "$venv_path/bin/activate"
    echo "Activated : $venv_path/bin/activate"
  else
    echo "Error: '$venv_path/bin/activate' not found!"
    return 1
  fi
}
