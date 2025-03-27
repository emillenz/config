#!/usr/bin/env bash

# ---
# title:  minimalist bashrc
# author: emil lenz
# email:  emillenz@protonmail.com
# date:   2024-11-30
# info:
#   - case insesitivity
#   - no colors, no syntax hilighting :: minimalism and focus (no unneccessary color fruit-salad).  only black/white and bold/regular.
#   - no bloated, "rewritten in rust" tools, that only add colours to everything or provide features already available.  we use the minimalist, readily available GNU coreutils (no unneccessary dependecies).  we use of aliases & functions for more ergonomic default behaviour.
# ---

alias\
	ls="ls --group-directories-first --format=single-column --file-type --color=never"\
	grep="grep --extended-regexp --ignore-case"\
	rm="rm --verbose --recursive --interactive=once"\
	mkdir="mkdir --verbose --parents"\
	bb-js="BABASHKA_PRELOADS='(def *js* (->> *in* slurp json/parse-string))' bb"\
	bb="rlwrap bb"\
	pgrep="pgrep --ignore-case"\
	less="less --ignore-case"

# no directories, no hidden files
# usage: `find [<pattern>] [<dirs>]*
function find { ( (($# == 1)) && command find "$1" -not -path './.*' ) || command find "${@:2:$#}" -iname "*$1*" -not -path './.*'; }

export\
	EDITOR="vi"\
	VISUAL="vi"

shopt -s\
	globstar\
	checkjobs\
	nocaseglob\
	nocasematch\
	histappend\
	patsub_replacement\
	autocd

export HISTCONTROL=ignoredups:erasedups\
	HISTSIZE=10000

# newline (\n) :: more clearly separate command outputs in history
# bold (\[\e]133;A\e\\\]) :: make prompt visually distinctive from commands/output
# tmux (\[\e[1m\]) :: needed to enable {next,prev}-prompt navigation.
export PS1=$'\n\[\e]133;A\\\]\[\e[1m\][\W] > \[\e[0m\]'
