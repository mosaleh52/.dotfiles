# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.8
# Enable colors and change prompt:
# autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
#
 # History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
#bindkey -v
#export KEYTIMEOUT=1

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/mo/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mo/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/mo/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mo/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
fcd(){
    cd "$(find -type d | fzf)"
}
alias getpath="find -type f | fzf | sed 's/^../' | tr -d '\n' | xclip -selection c"
alias config='/usr/bin/git --git-dir=/home/mo/.cfg/ --work-tree=/home/mo'
alias km='kmonad $HOME/.config/kmonad/c.kbd'

#########################################
export EDITOR="/usr/bin/nvim"
alias config='/usr/bin/git --git-dir=/home/mo/.cfg/ --work-tree=/home/mo'
export GOPATH=/home/mo/go
export PATH=$GOPATH/bin:$PATH 
export PATH="$HOME/.poetry/bin:$PATH"

alias luamake=/home/mo/.local/share/nvim/lsp/lua/3rd/luamake/luamake
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

