### Installation
```
# Default setup (vim, go, node, ctags, misc dev tools)
$ curl -LSs https://github.com/casonclagg/dotfiles/raw/master/setup | bash

# Full install with errthang (default + i3wm, chrome, docker and other apps I use)
$ curl -LSs https://github.com/casonclagg/dotfiles/raw/master/setup | bash -s -- -f

# Minimal install (just vim)
$ curl -LSs https://github.com/casonclagg/dotfiles/raw/master/setup | bash -s -- -m
```


Git Config
----------
Some standard configuration for git is included in `~/.gitconfig`
For your custom settings that wont be shared (like `name` and `email`) can be put in `~/.gitconfig_local` thusly:
```
[user]
    name = "Your Name"
    email = "your@email.com"
```

