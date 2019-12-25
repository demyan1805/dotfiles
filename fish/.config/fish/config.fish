if test -e "$__fish_config_dir/config.tokens.fish"
    source "$__fish_config_dir/config.tokens.fish"
end

set -x BAT_PAGER never
set -x BAT_STYLE plain
set -x BAT_THEME base16
set -x DF_STATS "table {{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}\t{{.PIDs}}"
set -x EDITOR nvim
set -x TERM alacritty
set -x FZF_DEFAULT_COMMAND "fd -i -H"
set -x FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --color=dark --color=fg:15,bg:0,bg+:0,hl:6,hl+:6 --color=info:2,prompt:1,pointer:12,marker:4,spinner:11,header:6"
set -x GOPATH $HOME/go
set -x LANG en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -x PYTHONBREAKPOINT ipdb.set_trace
set -x PIPENV_VENV_IN_PROJECT 1
set -x PYENV_ROOT $HOME/.pyenv
set -x PYTEST_ADDOPTS -x --ff --pdb --pdbcls=IPython.terminal.debugger:TerminalPdb

# TODO: append only if there is no value like with _PATH_PREPEND
set -x CFLAGS {$CFLAGS} -I(xcrun --show-sdk-path)/usr/include/
set -x CPPFLAGS {$CPPFLAGS} -I/usr/local/opt/zlib/include
set -x LDFLAGS {$LDFLAGS} -L/usr/local/opt/zlib/lib
set -x PKG_CONFIG_PATH {$PKG_CONFIG_PATH} /usr/local/opt/zlib/lib/pkgconfig

pyenv init - | source

set _PATH_PREPEND \
    /usr/local/opt/icu4c/bin \
    /usr/local/opt/gnu-getopt/bin \
    /usr/local/opt/gettext/bin \
    /usr/local/opt/ruby/bin \
    $HOME/.cargo/bin \
    $HOME/.local/bin \
    $GOPATH/bin \
    $HOME/.pyenv/shims

if test -n $VIRTUAL_ENV # append virtual env /bin path
    set -gx _PATH_PREPEND $_PATH_PREPEND $VIRTUAL_ENV/bin
end

for item in $_PATH_PREPEND # (re) prepend PATH
    set -gx PATH (string match -v $item $PATH)
    set -gx PATH $item $PATH
end

set -g pure_threshold_command_duration 2

abbr -a dc docker-compose
abbr -a dex docker exec -it
abbr -a dig dig +short
abbr -a do docker
abbr -a ga git add
abbr -a gc git commit
abbr -a gca git commit --amend
abbr -a gco git checkout
abbr -a gd git diff
abbr -a gs git status
abbr -a l ls -la
abbr -a tm tmux -u
abbr -a vim nvim
abbr -a run ./manage.py runserver

alias dsa 'docker stop (docker ps -q)'
alias dps 'docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}\t{{.Status}}"'
alias ssh 'env TERM=xterm-256color ssh'
alias top 'top -o cpu'
alias tldr 'tldr -t ocean'

if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"

    # Colors:
    # black, red, green, yellow, blue, magenta, cyan, white
    # brblack, brred, brgreen, bryellow, brblue, brmagenta, brcyan, brwhite
    set fish_color_normal normal # the default color
    set fish_color_command blue # the color for commands
    set fish_color_quote green # the color for quoted blocks of text
    set fish_color_redirection brmagenta # the color for IO redirections
    set fish_color_end magenta # the color for process separators like ';' and '&'
    set fish_color_error red # the color used to highlight potential errors
    set fish_color_param normal # the color for regular command parameters
    set fish_color_comment brblack # the color used for code comments
    set fish_color_match --background=cyan # the color used to highlight matching parenthesis
    set fish_color_selection green # the color used when selecting text (in vi visual mode)
    set fish_color_search_match --background=brblack # used to highlight history search matches and the selected pager item (must be a background)
    set fish_color_operator magenta # the color for parameter expansion operators like '*' and '~'
    set fish_color_escape magenta # the color used to highlight character escapes like '\n' and '\x70'
    set fish_color_cwd brblue # the color used for the current working directory in the default prompt
    set fish_color_autosuggestion -d # the color used for autosuggestions
    set fish_color_user brcyan # the color used to print the current username in some of fish default prompts
    set fish_color_host brblue # the color used to print the current host system in some of fish default prompts
    set fish_color_cancel brred # the color for the '^C' indicator on a canceled command

    # set fish_pager_color_prefix # the color of the prefix string, i.e. the string that is to be completed
    # set fish_pager_color_completion # the color of the completion itself
    set fish_pager_color_description bryellow # the color of the completion description
    set fish_pager_color_progress brcyan # the color of the progress bar at the bottom left corner
    # set fish_pager_color_secondary # the background color of the every second completion

    if test \( "$POETRY_ACTIVE" = "1" \) -a \( -f .env \)
        posix_source # source .env on poetry shell activate
        if test -f .env.local
            posix_source .env.local
        end
    end

    function __set_tmux_window_title -a title
        tmux rename-window $title
        set -g tmux_window_title $title
    end

    function __fish_preexec_handler -e fish_preexec
        switch $argv
            case "./manage.py runserver*"
                __set_tmux_window_title "django-server"
            case "http-prompt*"
                __set_tmux_window_title "http-prompt"
            case "nvim *.tmux.conf"
                __set_tmux_window_title ".tmux.conf"
            case "nvim *.vimrc"
                __set_tmux_window_title ".vimrc"
        end
    end

    function __fish_postexec_handler -e fish_postexec
        set -q tmux_window_title
        if test $status -eq 0
            tmux rename-window "fish"
            set -e tmux_window_title
        end
    end

    if type -q register-python-argcomplete
        register-python-argcomplete --shell fish pipx | .
    end

    # starship init fish | source
end
