#  ---
#  title:  fish prompt
#  author: emil lenz
#  email:  emillenz@protonmail.com
#  date:   2024-05-05
#  info:   we color prompt-background & add a newline in order to make the prompts visually distictive from command output.
#  ---

function fish_prompt
    set -l last_status $status # NOTE :: must be first statement
    set -l stat
    if test $last_status -ne 0
        set stat (set_color $fish_color_error)"[$last_status]"
    end

    set -l dir (set_color $fish_color_cwd)(prompt_pwd --full-length-dirs 4)
    set -l delimiter (set_color $fish_color_command)">"

    set -l fish_color_line_bg '#dae5ec'
    echo \n (set_color --background=$fish_color_line_bg --bold) $dir $stat $delimiter (set_color normal) ""
end
