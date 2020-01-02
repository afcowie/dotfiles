# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

function timer_start {
	timer=${timer:-$SECONDS}
}

function timer_stop {
	count=$(($SECONDS - $timer))
	if [ $count -ne 0 ] ; then
		timer_show=" $(($SECONDS - $timer))s"
	else
		timer_show=""
	fi
	unset timer
}

trap 'timer_start' DEBUG


if [ "$PROMPT_COMMAND" == "" ]; then
	PROMPT_COMMAND="timer_stop"
else
	PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"
fi

if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ] ; then
	source /usr/share/git-core/contrib/completion/git-prompt.sh
fi

#export PS1='\[\e[00;32m\]\h \[\e[00;36m\]\w$(__git_ps1 "\[\e[00;34m\] %s\[\e[00;36m\]")\n\$ \[\e[00m\]'

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWCOLORHINTS=true
# With timestamps
# (pre)
#export PS0='\e[38;5;108m$(date +%FT%TZ -u)\e[00m\n'
# (command runs)
# (post)
#export PS1='\[\e[38;5;108m\]$(date +%FT%TZ -u)\[\e[00m\]\n\[\e[00;32m\]\h \[\e[00;36m\]\w$(__git_ps1 "\[\e[00;34m\] %s") \[\e[38;5;244m\]\$ \[\e[00m\]'

unset PS0
export PS1='\[\e[38;5;108m\]$(date +%FT%TZ -u)${timer_show}\[\e[00m\]\n\[\e[00;32m\]\h \[\e[00;36m\]\w$(__git_ps1 "\[\e[00;34m\] %s") \[\e[38;5;244m\]\$ \[\e[00m\]'

alias ls="ls -p --color=auto"

unset HISTFILESIZE
export HISTSIZE=50000

shopt -sq cdspell
shopt -sq checkwinsize
shopt -sq no_empty_cmd_completion
shopt -sq histappend cmdhist lithist

export LESS="-j12 -R"

export PATH="/home/andrew/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin"

export EDITOR=vim
alias dnf='echo "not for you, dnf"'
alias virsh='echo "not for you, virsh"'
alias now='date -u +%FT%TZ'

open () {
	/usr/bin/xdg-open "$@" >/dev/null 2>&1 
}

umask 0022
