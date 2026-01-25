autoload -U colors && colors
setopt PROMPT_SUBST   # enables $(...) inside PROMPT

git_branch() {
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  [[ -n "$branch" ]] && echo "[$branch]"
}

prompt_venv() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    echo "(${VIRTUAL_ENV:t}) "
  fi
}

fullprompt() {
  PROMPT='%{$fg_bold[green]%}$(prompt_venv)%{$fg_bold[blue]%}%~ %{$fg_bold[magenta]%}$(git_branch)%{$reset_color%} %# '
}

shortprompt() {
  # %1~ = only the last path component (with ~ for $HOME)
  PROMPT='%{$fg_bold[green]%}$(prompt_venv)%{$fg_bold[blue]%}%1~ %{$fg_bold[magenta]%}$(git_branch)%{$reset_color%} %# '
}

shortplus() {
  # %2~ = last two path components
  PROMPT='%{$fg_bold[green]%}$(prompt_venv)%{$fg_bold[blue]%}%2~ %{$fg_bold[magenta]%}$(git_branch)%{$reset_color%} %# '
}

# pick a default style for new shells:
fullprompt
