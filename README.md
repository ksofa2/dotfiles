```
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no
dotfiles remote add origin git@github.com:ksofa2/dotfiles.git
dotfiles pull origin master
dotfiles branch --set-upstream-to=origin/master master
dotfiles submodule update --init --depth=1
source $HOME/.zshrc
```