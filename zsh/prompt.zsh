autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "$(git_prompt_info) %{$reset_color%}"
    else
      echo "$(git_prompt_info) %{$fg[yellow]%}✗ %{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "%{$fg_bold[blue]%}git:(%{$fg_bold[red]%}${ref#refs/heads/}%{$fg_bold[blue]%})%{$reset_color%}"
}

directory_name() {
  echo "%{$fg[cyan]%}%1/%\/%{$reset_color%}"
}

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"

export PROMPT='${ret_status} $(directory_name) $(git_dirty)'

set_prompt () {
  export RPROMPT="%{$fg_bold[blue]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
