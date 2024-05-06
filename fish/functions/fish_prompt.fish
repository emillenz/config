#  ---
#  title:  fish prompt
#  author: emil lenz
#  email:  emillenz@protonmail.com
#  date:   2024-05-05
#  ---

function fish_prompt
        set -l sep (set_color --background='#f2f2f2') (string repeat --count (math (tput cols) - 3) " ") (set_color normal) \n
        set -l stat
        if test $status -ne 0
                set stat (set_color red)"[$status]"
        end
        set -l dir (set_color '#005f5f') (prompt_pwd --full-length-dirs 4)
        set -l delimiter (set_color '#0031a9') ">"

        echo \n (set_color --background='#dae5ec' --bold) $dir $stat $delimiter (set_color normal) ""
end
