ZSH_THEME_VIRTUALENV_SUFFIX="] "

local ret_status="%(?::%{$fg_bold[red]%}%? )"
PROMPT='%{$fg[cyan]%}%c%{$reset_color%} ${ret_status}%#%{$reset_color%} '

# PROMPT='%{$fg[blue]%}${virtualenv_prompt_info}%{$reset_color%}%{$fg[cyan]%}%c%{$reset_color%} ${ret_status}%#%{$reset_color%} '