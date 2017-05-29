```
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no
dotfiles remote add origin {{ site.github.repository_html_url }}
dotfiles pull origin master
dotfiles branch --set-upstream-to=origin/master master
dotfiles submodule update --init --depth=1
source $HOME/.zshrc
```
