# zplug
source ~/.zplug/init.zsh

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/nvm", from:oh-my-zsh
zplug "plugins/redis-cli", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/heroku", from:oh-my-zsh
zplug "plugins/cargo", from:oh-my-zsh
zplug "plugins/node", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh

zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load


# history config
HISTFILE=~/.zsh_history     #Where to save history to disk
HISTSIZE=5000               #How many lines of history to keep in memory
SAVEHIST=1000000
setopt append_history     #Append history to the history file (no overwriting)
setopt share_history      #Share history across terminals
setopt incappendhistory  #Immediately append to the history file, not just when a term is killed
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it


# user config
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -o -selection clipboard"

# otherwise colors don't work in some environments
alias tmux="TERM=screen-256color-bce tmux"

alias vi='vim -X'

alias la='ls -lahF'
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'

alias gip='git pull'
alias gipu='git push'
alias gis='git status'
alias gif='git diff'
alias gia='git add'
alias giap='git add -p'
alias gic='git commit'
alias gil='git log --decorate'
alias gig='git grep -i -n'

alias beep='spd-say -t female1 "done"'

alias dodu='docker-compose down && docker-compose up -d'
# ubuntu shell with working locale (pw: ubuntu)
alias throwaway-ubuntu='docker run --name throwaway-ubuntu --rm -e LANG=en_US.UTF-8 -e LANGUAGE=en_US:en -e LC_ALL=en_US.UTF-8 -it ubuntu /bin/bash -c "apt update && apt install locales sudo && locale-gen en_US.UTF-8 && useradd -m -G sudo -p mSJ3LdwLXNs8E ubuntu && su ubuntu && bash"'

# Use vi as the default editor
export VISUAL=vim
export EDITOR="$VISUAL"
# But still use emacs-style zsh bindings
bindkey -e

export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.local/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PGHOST=127.0.0.1
export PGUSER=postgres

# golang
export GOROOT=/usr/local/go
export GOPATH=$HOME/src/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:$HOME/.cargo/bin

# fly
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# gpg ssh
if command -v gpgconf &> /dev/null
then
	export GPG_TTY=$(tty)

	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
	gpgconf --launch gpg-agent > /dev/null
	gpg-connect-agent updatestartuptty /bye > /dev/null
fi
