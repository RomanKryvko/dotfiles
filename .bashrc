#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias nightmode='redshift -P -O 5000'
alias daymode='redshift -x'
alias pacman-update='date >> update-log.txt && sudo pacman -Syu | tee -a update-log.txt'
alias copy='xsel -ib'
alias paste='xsel -ob'

# My programs
alias wp='~/.local/bin/cppalery/cppalery ~/Pictures/Wallpapers'
alias todo='~/.local/bin/todo-app/todo'

parse_git_branch() {
if [ "$PWD" != "$HOME" ]; then
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
fi
}
export PS1='┌─\[\e[92m\](\u\[\e[0m\]@\[\e[92m\]\h)\[\e[0m\]─[\[\e[94m\]\w\[\e[0m\]]\[\e[93m\]$(parse_git_branch)\n\[\e[0m\]└─\$ '
source /usr/share/nvm/init-nvm.sh
