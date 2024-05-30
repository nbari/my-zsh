# ----------------------------------------------------------------------------
# variables
# ----------------------------------------------------------------------------
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export CLICOLOR=1
export EDITOR=nvim
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LESSCHARSET=utf-8
export LSCOLORS=Exfxcxdxbxegedabagacad
export PAGER='less -R'
export SSH_AUTH_SOCK=$HOME/.1password/agent.sock

# ----------------------------------------------------------------------------
# Advanced Tab-completion
# ----------------------------------------------------------------------------
autoload -Uz compinit && compinit

# ----------------------------------------------------------------------------
# vim mode
# ----------------------------------------------------------------------------
bindkey -v
bindkey "^?" backward-delete-char

# ----------------------------------------------------------------------------
# csh history
# ----------------------------------------------------------------------------
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
bindkey -M vicmd 'k' up-line-or-beginning-search # Up
bindkey -M vicmd 'j' down-line-or-beginning-search # Down

# ----------------------------------------------------------------------------
# magic-space
# ----------------------------------------------------------------------------
bindkey " " magic-space # do history expansion on space !XX<space>

# ----------------------------------------------------------------------------
# Edit command using vim - hit ESC and then v
# emacs mode:  Ctrl-x e -  bindkey '^Xe' edit-command-line
# ----------------------------------------------------------------------------
export KEYTIMEOUT=1
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# ----------------------------------------------------------------------------
# shell options
# ----------------------------------------------------------------------------
setopt complete_aliases
setopt autocd
setopt autopushd
setopt pushdminus
setopt pushdsilent
setopt pushdtohome
setopt pushd_ignore_dups

# ----------------------------------------------------------------------------
# Command history configuration
# ----------------------------------------------------------------------------
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=10000
SAVEHIST=10000

# Show history
case $HIST_STAMPS in
    "mm/dd/yyyy") alias history='fc -fl 1' ;;
    "dd.mm.yyyy") alias history='fc -El 1' ;;
    "yyyy-mm-dd") alias history='fc -il 1' ;;
    *) alias history='fc -l 1' ;;
esac

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# ----------------------------------------------------------------------------
# zstyle
# ----------------------------------------------------------------------------
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path "$HOME/.zcache"
zstyle ':completion:*' use-ip true
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' file-sort modification
# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# kill
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)[ 0-9:]#([^ ]#)*=01;38=01;31=01;30'
# Rehash when completing commands
zstyle ":completion:*:commands" rehash 1
# ls colors
zstyle ':completion:*' list-colors 'di=94:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# ----------------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------------
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias active='grep -Ev "^($|#)"'
alias b="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '\$1 ~ /percentage/{print \$2}'"
alias c='clear'
alias connected='lsof -i | grep -E "(LISTEN|ESTABLISHED)"'
alias cp='cp -i'
alias cpr='rsync --delete --archive --numeric-ids --human-readable --verbose --info=progress2'
alias d='dirs -v | head -10'
alias dev='git checkout develop'
alias sand='git checkout sandbox'
alias gd="echo main diff:; git diff --name-status main develop"
alias gl="git log --decorate --graph --oneline --all --date=short --pretty=format:'%C(bold blue)%ad%Creset %C(yellow)%h%Creset%C(auto)%d%Creset %s %C(dim magenta)<%an>%Creset %C(dim green)(%ar)%Creset'"
alias h='history'
alias less='less -FSRX'
alias listen='lsof -iTCP -sTCP:LISTEN -n -P'
alias main='git checkout main'
alias master='git checkout master'
alias mv='mv -i'
alias myip="dig @ns1.google.com -t txt o-o.myaddr.l.google.com +short"
alias path='echo -e ${PATH//:/\\n}'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias pro='cd ~/projects'
alias profile="cat /sys/firmware/acpi/platform_profile; echo fn + h,m,l"
alias rand='LC_ALL=C cat /dev/urandom | tr -dc a-zA-Z0-9 | fold -w 16 | head -n 1'
alias rm='rm -i'
alias ssh-tunnel='echo "ssh -C2qTnN -D 8080 (proxy) or -T -N -f -L 3307:db.tld:3307 host.tld"'
alias ssh="TERM=xterm-256color ssh"
alias t="tmux -2 attach -d || tmux -2 new"
compdef t=tmux
alias tl='tmux list-sessions'
alias tmp='cd ~/tmp'
alias up='git add . && git commit -am "sync $(date)" && git push'
alias yk='gpg --card-status > /dev/null'
alias clip='cargo clippy --all -- -W clippy::all -W clippy::pedantic -W clippy::nursery -D warnings'

# nvim
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias vimdiff="nvim -d"



if (( ${+commands[exa]} )); then
    LS_COMMAND='exa'
elif (( ${+commands[eza]} )); then
    LS_COMMAND='eza'
else
    LS_COMMAND='ls'
fi

if [[ $LS_COMMAND == 'ls' ]]; then
    alias l='ls -lah'
    alias ll='ls -alF'
    alias la='ls -A'
else
    alias ls="$LS_COMMAND"
    alias l="$LS_COMMAND -l --all --group-directories-first --git"
    alias ll="$LS_COMMAND -l --all --all --group-directories-first --git"
    alias lt="$LS_COMMAND --icons -T --git-ignore --level=2 --group-directories-first"
    alias llt="$LS_COMMAND --icons -lT --git-ignore --level=2 --group-directories-first"
    alias lT="$LS_COMMAND --icons -T --git-ignore --level=4 --group-directories-first"
    alias llm="$LS_COMMAND -lbGF --git --sort=modified"  # long list, modified date sort
    alias la="$LS_COMMAND -lbhHigUmuSa --time-style=long-iso --git --color-scale"  # all list
    alias lx="$LS_COMMAND -lbhHigUmuSa@ --time-style=long-iso --git --color-scale" # all + extended list
fi

# ----------------------------------------------------------------------------
# use OS time
# ----------------------------------------------------------------------------
# disable -r time

# ----------------------------------------------------------------------------
# prompt slick
# ----------------------------------------------------------------------------
zle -N zle-keymap-select
zle -N zle-line-init
zmodload zsh/datetime
autoload -Uz add-zsh-hook

SLICK_PATH=$HOME/.cargo/bin/slick

function slick_prompt_refresh {
    local exit_status=$?
    read -r -u $1 slick_prompt_data
    PROMPT=$($SLICK_PATH prompt -k "$KEYMAP" -r $exit_status -d ${slick_prompt_data:-""} -t ${slick_prompt_timestamp:-$EPOCHSECONDS})
    unset slick_prompt_timestamp

    zle reset-prompt

    # Remove the handler and close the fd
    zle -F $1
    exec {1}<&-
}

function zle-line-init zle-keymap-select {
    PROMPT=$($SLICK_PATH prompt -k "$KEYMAP" -d ${slick_prompt_data:-""})
    zle && zle reset-prompt
}

function slick_prompt_precmd() {
    slick_prompt_data=""
    local fd
    exec {fd}< <($SLICK_PATH precmd)
    zle -F $fd slick_prompt_refresh
}

function slick_prompt_preexec() {
    slick_prompt_timestamp=$EPOCHSECONDS

    # Set cursor style (DECSCUSR), VT520.
    # 0  ⇒  blinking block.
    # 1  ⇒  blinking block (default).
    # 2  ⇒  steady block.
    # 3  ⇒  blinking underline.
    # 4  ⇒  steady underline.
    # 5  ⇒  blinking bar, xterm.
    # 6  ⇒  steady bar, xterm.

    echo -ne "\e[4 q";
}

typeset -g slick_prompt_data
typeset -g slick_prompt_timestamp
add-zsh-hook precmd slick_prompt_precmd
add-zsh-hook preexec slick_prompt_preexec

export SLICK_PROMPT_GIT_REMOTE_BEHIND=""
export SLICK_PROMPT_GIT_REMOTE_AHEAD=""

# ----------------------------------------------------------------------------
# custom
# ----------------------------------------------------------------------------

# get PID/PGID/PPID/SID to certain process or pid:
pgid() {
    ps -ejf | egrep "STIME | $1" | grep -v egrep
}

get_headers_GET() {
    curl -i -L -s -H "Accept-Encoding: gzip,deflate" -A "$(hostname) - [$(date -u '+%FT%T')]" -D - $1 -o /dev/null
}

get_headers() {
    curl -I -L -H "Accept-Encoding: gzip,deflate" -H "Origin: http://example.com" -H "Access-Control-Request-Method: GET" $1
}

get_options() {
    curl -I -L -X OPTIONS -H "Origin: http://example.com" -H "Access-Control-Request-Method: GET" -H "Access-Control-Request-Headers: X-Requested-With" $1
}

get_akamai() {
    curl -I -L -H "Pragma: akamai-x-cache-on, akamai-x-cache-remote-on, akamai-x-check-cacheable, akamai-x-get-cache-key, akamai-x-get-extracted-values, akamai-x-get-nonces, akamai-x-get-ssl-client-session-id, akamai-x-get-true-cache-key, akamai-x-serial-no, akamai-x-get-request-id, akamai-x-request-trace, akamai-x--meta-trace, akama-xi-get-extracted-values" $1
}

curl_time() {
    curl -o /dev/null -Ls -w " \
        time_namelookup:  %{time_namelookup}\n \
        time_connect:  %{time_connect}\n \
        time_appconnect:  %{time_appconnect}\n \
        time_pretransfer:  %{time_pretransfer}\n \
        time_redirect:  %{time_redirect}\n \
        time_starttransfer:  %{time_starttransfer}\n \
        ----------\n \
        time_total:  %{time_total}\n" "$1"
}

# ----------------------------------------------------------------------------
# Kill all process that match $1
# ----------------------------------------------------------------------------
kill9() {
    pkill -9 -f "$1" && echo "Killed $(pgrep -f "$1")"
}

# ----------------------------------------------------------------------------
# ssh+tmux
# ----------------------------------------------------------------------------
export AUTOSSH_GATETIME=0
export AUTOSSH_POLL=10
export AUTOSSH_PORT=0
s() {
    [[ ! -z $1 ]] && autossh -M 0 -t $@ 'tmux -2 new -ADs $USER'
}
compdef s=ssh

m() {
    [[ ! -z $1 ]] && mosh $@ -- tmux -2 new -ADs $USER
}

# multiple tmux windows
ms() {
    [[ ! -z $1 ]] && tmux new-window; while read line; do (tmux split-window -h "autossh -M0 $line $2"; tmux select-layout tiled); done< <(awk '{print $NF}' <(host $1); tmux kill-pane -t0)
}

# ----------------------------------------------------------------------------
# tmux
# ----------------------------------------------------------------------------
# if command -v tmux &> /dev/null; then
#     if [ -z "$TMUX" ]; then
#         tmux -2 new
#     elif [[ $(who am i) =~ '\([-a-zA-Z0-9\.]+\)$' ]] || [ ! -z "$SSH_CONNECTION" ] || [ ! -z "$REMOTEHOST" ]; then
#         tmux set-option -g status-right '#[fg=colour003][ #H - #[fg=colour111]#(uname) #[fg=colour003]]#[fg=colour231]#(uptime | grep -o "...user.*")' > /dev/null
#         tmux set-option -g status-position bottom > /dev/null
#         tmux set-option -g window-status-current-bg colour071 > /dev/null
#         tmux has-session || tmux -2 new
#     fi
# fi

# ----------------------------------------------------------------------------
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
# ----------------------------------------------------------------------------
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_TMUX=1

# ----------------------------------------------------------------------------
# command history
# ----------------------------------------------------------------------------
fh() {
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}
