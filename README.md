dotfiles
--------

This repo contains my dotfiles and scripts to help keep my environments in sync. Also included is an [install](install-apt) script to quickly install the neccessary dependencies (zsh, vim, etc.) on new machines.

### Usage
#### Provision a new machine
```
git clone --depth 1 https://github.com/patte/dotfiles.git
cd dotfiles
./setup
```

#### Commit locally edited files
```
./get
git add -p
git commit
```

#### Update local files
```
git pull
./put
```


### Notes
This repo contains the following personalized files to make setting up new machines as fast as possible.
- [.gnupg/sshcontrol](.gnupg/sshcontrol)
- [.gitconfig](.gitconfig)

### Credits
Thanks [paddor](https://github.com/paddor) for providing the [basis](https://github.com/paddor/dotfiles/) for this repo.
