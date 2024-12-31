# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/yuki/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

source '/usr/share/zsh-antidote/antidote.zsh'
antidote load

export EDITOR='nvim'

eval "$(rbenv init -)"
# proto
export PROTO_HOME="$HOME/.proto";
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH";


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# ghcup
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
# dotnet
export DOTNET_ROOT="$HOME/.dotnet";
export PATH="$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools";
