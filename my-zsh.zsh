# ----------------------------------------------------------------------------
# variables
# ----------------------------------------------------------------------------
export PATH="$PATH:$HOME/projects/go/bin:$HOME/.cargo/bin:$HOME/.local/bin:/snap/bin"
export SSH_AUTH_SOCK=~/.1password/agent.sock
export CLICOLOR=1
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LSCOLORS=Exfxcxdxbxegedabagacad
export EDITOR=vim
export LESSCHARSET=utf-8
export PAGER='less -R'

# ----------------------------------------------------------------------------
# PYENV - curl https://pyenv.run | bash
# ----------------------------------------------------------------------------
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ----------------------------------------------------------------------------
# zsh functions path
# ----------------------------------------------------------------------------
fpath+=${ZDOTDIR:-~}/.zsh_functions

# ----------------------------------------------------------------------------
# vim mode
# ----------------------------------------------------------------------------
bindkey -v
bindkey "^?" backward-delete-char

# ----------------------------------------------------------------------------
# Advanced Tab-completion
# ----------------------------------------------------------------------------
autoload -U compinit && compinit

# ----------------------------------------------------------------------------
# remove duplicates in the PATH
# ----------------------------------------------------------------------------
typeset -U PATH

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
# alias for directories
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
alias d='dirs -v | head -10'
alias connected='lsof -i | grep -E "(LISTEN|ESTABLISHED)"'
alias listen='lsof -iTCP -sTCP:LISTEN -n -P' 

# ----------------------------------------------------------------------------
# prompt
# ----------------------------------------------------------------------------
zle -N zle-keymap-select
zle -N zle-line-init
zmodload zsh/datetime
autoload -Uz add-zsh-hook
add-zsh-hook precmd slick_prompt_precmd
add-zsh-hook preexec slick_prompt_preexec

typeset -g slick_prompt_data
typeset -g slick_prompt_timestamp

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
}


# ----------------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------------
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias b="upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '\$1 ~ /percentage/{print \$2}'"

if type exa 2>&1 >/dev/null; then
  alias ls='exa'
  alias l='exa -l --all --group-directories-first --git'
  alias ll='exa -l --all --all --group-directories-first --git'
  alias lt='exa --icons -T --git-ignore --level=2 --group-directories-first'
  alias llt='exa --icons -lT --git-ignore --level=2 --group-directories-first'
  alias lT='exa --icons -T --git-ignore --level=4 --group-directories-first'
else
  alias l='ls -lah'
  alias ll='ls -alF'
  alias la='ls -A'
fi

alias ssh="TERM=xterm-256color ssh"
