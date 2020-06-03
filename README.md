### Installation
```
# Default setup (vim, go, node, ctags, misc dev tools)
$ curl -LSs -H 'Cache-Control: no-cache' https://github.com/casonclagg/dotfiles-full/raw/master/setup | bash

# Full install with errthang (default + i3wm, chrome, docker and other apps I use)
$ curl -LSs -H 'Cache-Control: no-cache' https://github.com/casonclagg/dotfiles-full/raw/master/setup | bash -s -- -f

# Minimal install (just vim)
$ curl -LSs -H 'Cache-Control: no-cache' https://github.com/casonclagg/dotfiles-full/raw/master/setup | bash -s -- -m
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

Local Files
-----------
There's a special local files folder somewhere secret! Use it.

