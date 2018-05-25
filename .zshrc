export ZSH=/home/epergo/.oh-my-zsh

################### OH MY ZSH CUSTOMIZATION
ZSH_THEME="robbyrussell"
UPDATE_ZSH_DAYS=7
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git)

stty start '^-' stop '^-' # Disable ctrl+q ctrl+s

source $ZSH/oh-my-zsh.sh

## Prompt styling
local ret_status="%(?:%{$fg_bold[green]%}➜:%{$fg_bold[red]%}➜)"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=""
PROMPT=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info) ${ret_status} %{$reset_color%}'


#################### ALIASES
alias v="vim"
alias be="bundle exec"
alias dev="cd ~/development"
alias ccat="pygmentize"
alias doc="docker-compose"

alias k="kubectl"
alias klc="kubectl config get-contexts -o=name | sort -n"
alias kuc="kubectl config use-context"
alias m="minikube"

#################### HISTORY CONFIG
# https://github.com/mattjj/my-oh-my-zsh/blob/master/history.zsh
# source $ZSH/.history.sh

HISTFILE="$HOME/.zhistory"
HISTSIZE=10000
SAVEHIST=10000

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Do not record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.


#################### PATH CONFIGURATION
export PATH="$PATH:$HOME/development/bin"


#################### TOOLS
# https://github.com/clvv/fasd
eval "$(fasd --init auto)"

## https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## https://github.com/asdf-vm/asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

## Google Cloud CLI - Updates PATH for the Google Cloud SDK.
#if [ -f "$HOME/development/bin/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/development/bin/google-cloud-sdk/path.zsh.inc"; fi

## Google Cloud CLI - Enables shell command completion for gcloud.
#if [ -f "$HOME/development/bin/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/development/bin/google-cloud-sdk/completion.zsh.inc"; fi

# kubectl completion
#source <(kubectl completion zsh)

# Display kubectl context
#KUBE_PS1_SUFFIX=" "
#KUBE_PS1_PREFIX=" "
#KUBE_PS1_SEPARATOR=
#KUBE_PS1_NS_ENABLE=false

#source ~/.kube-ps1/kube-ps1.sh
#PROMPT='$(kube_ps1)| '$PROMPT

################### STYLING
# Base16 style ==> https://github.com/chriskempson/base16-shell
# BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
