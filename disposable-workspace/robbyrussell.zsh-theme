PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

RPROMPT='$(git_prompt_status)%{$reset_color%}'

# Incompatible with docker exec tty, worked on macOS
# ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ✈"
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ✭"
# ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✗"
# ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➦"
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ✂"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%} ✱"
