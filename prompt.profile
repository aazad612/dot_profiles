autoload -U colors && colors
setopt PROMPT_SUBST   # enables $(...) inside PROMPT

# Show current git branch
git_branch() {
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  [[ -n "$branch" ]] && echo "[$branch]"
}

# Show virtualenv name
prompt_venv() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "(${VIRTUAL_ENV:t}) "
  fi
}

# Final prompt: (venv) ~/path/to/folder [branch] %
PROMPT='%{$fg_bold[green]%}$(prompt_venv)%{$fg_bold[blue]%}%~ %{$fg_bold[magenta]%}$(git_branch)%{$reset_color%} %# '