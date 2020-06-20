## oh-my-zsh

```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## plugins

git wd autojump zsh-syntax-highlighting zsh-autosuggestions

### autojump

```
git clone git://github.com/wting/autojump.git ~/Downloads/autojump

cd autojump
./install.py or ./uninstall.py
```

add this to .zshrc

```
[[ -s /root/.autojump/etc/profile.d/autojump.sh ]] && source /root/.autojump/etc/profile.d/autojump.sh

autoload -U compinit && compinit -u
```


### zsh-syntax-highlight

```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### zsh-autosuggestions

```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

setup shortcut key

```
bindkey ',' autosuggest-accept
```