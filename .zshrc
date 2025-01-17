# zplug
source ~/.zplug/init.zsh

zplug "plugins/git", from:oh-my-zsh
zplug "plugins/nvm", from:oh-my-zsh
#zplug "plugins/redis-cli", from:oh-my-zsh
#zplug "plugins/sudo", from:oh-my-zsh
zplug "plugins/cargo", from:oh-my-zsh
zplug "plugins/node", from:oh-my-zsh
#zplug "plugins/npm", from:oh-my-zsh

zplug "spaceship-prompt/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
#SPACESHIP_PACKAGE_SHOW=false
#SPACESHIP_DOCKER_SHOW=false
SPACESHIP_HOST_SHOW=always

#zplug "zsh-users/zsh-syntax-highlighting", defer:2

# up and down keys search history to complete current prompt 🙏
zplug "robbyrussell/oh-my-zsh", use:"lib/key-bindings.zsh"
zplug "robbyrussell/oh-my-zsh", use:"lib/directories.zsh"


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

alias ls='ls --color=auto'
alias la='ls -lahF --color=auto'
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'

alias grep='grep --color=auto'

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

# ubuntu shell
alias throwaway-ubuntu-bare='docker run --name throwaway-ubuntu-bare --rm -it ubuntu:22.04 /bin/bash'

# ubuntu shell with working locale and user
# user: ubuntu / ubuntu
# openssl passwd -crypt ubuntu
alias throwaway-ubuntu='docker run --name throwaway-ubuntu --rm -e LANG=en_US.UTF-8 -e LANGUAGE=en_US:en -e LC_ALL=en_US.UTF-8 -it ubuntu:22.04 /bin/bash -c "apt update && apt install locales sudo && locale-gen en_US.UTF-8 && useradd -m -G sudo -p mSJ3LdwLXNs8E ubuntu && su ubuntu && bash"'

#<https://security.stackexchange.com/questions/223054/gpg2-how-to-get-rid-of-please-insert-card-with-serial-number-getting-the-sam>
alias fuck-gpg='
rm .gnupg/private-keys-v1.d/*
gpgconf --kill gpg-agent
gpg-connect-agent reloadagent /bye
gpg-connect-agent updatestartuptty /bye
gpg --card-status
'


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
if command -v gpgconf &> /dev/null && [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]
then
	export GPG_TTY=$(tty)

	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
	gpgconf --launch gpg-agent > /dev/null
	gpg-connect-agent updatestartuptty /bye > /dev/null
fi

# pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"

# atuin
#eval "$(atuin init zsh)"
