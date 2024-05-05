#  ---
#  title:  fish prompt
#  author: emil lenz
#  email:  emillenz@protonmail.com
#  date:   2024-05-05
#  ---

function fish_prompt
    set -l sep (string repeat --count (math (tput cols) - 2) "─")
    set -l stat
    if test $status -ne 0
        set stat (set_color red)"[$status]"(set_color normal)
    end
    set -l dir (set_color magenta) (prompt_pwd --full-length-dirs 4) (set_color normal)

    echo \n (set_color --bold) \n $sep \n $dir $stat ":: " (set_color normal)
end
