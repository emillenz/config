#!/usr/bin/env bash

# ---
# title:  bash shell config
# author: emil lenz
# email:  emillenz@protonmail.com
# date:   2024-11-30
# ---

alias\
	ls="ls --group-directories-first --format=single-column --file-type --color=never"\
	grep="grep --extended-regexp --ignore-case"\
	rm="rm --verbose --recursive --interactive=once"\
	cp="cp --verbose --recursive"\
	mkdir="mkdir --verbose --parents"\
	pgrep="pgrep --ignore-case"\
	less="less --ignore-case"

export\
	EDITOR="vi"\
	VISUAL="vi"\
	HISTCONTROL=ignoredups:erasedups\
	HISTSIZE=10000

shopt -s\
	globstar\
	checkjobs\
	nocaseglob\
	nocasematch\
	histappend\
	patsub_replacement\
	autocd

# bold (\[\e]133;A\e\\\])
# tmux (\[\e[1m\]) :: needed to enable {next,prev}-prompt navigation.
export PS1='\n\[\e]133;A\\\]\[\e[1m\][\W] \[\e[0m\]'

function find {
	command find $@ -not -path './.*'
}

function rjs { ruby -rjson -e 'in = JSON.parse(ARGF.read);'"$@" ; }

function sesh {
	local dir="${1:-"$(pwd)"}"
	local cmd="${2:-"vi"}"
	local name="$(basename $dir | tr '[:upper:]' '[:lower:]')"

	tmux has-session -t $name &>/dev/null || tmux new-session -d -c $dir -s $name $cmd
	[ -n $TMUX ] && tmux switch-client -t $name || tmux attach-session -t $name
}
