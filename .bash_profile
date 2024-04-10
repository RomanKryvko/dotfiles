#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

parse_git_branch() {
if [ "$PWD" != "$HOME" ]; then
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
fi
}
export PS1='┌─\e[32m(\u\e[0m\e[0m@\e[32m\h)\e[0m─[\e[94m\w\e[0m]\e[33m$(parse_git_branch)\n\e[0m└─\$ '
