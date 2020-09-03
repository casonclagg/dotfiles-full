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


TODO
-----
1. nvm is jacked up

    N/A: version "N/A -> N/A" is not yet installed.

    You need to run "nvm install N/A" to install it before using it.

3. script to get OS drive goodies into a safe backup
    - .bash_history
    - .ssh/
4. Setup multiple monitors for i3
    - Currently have to use `sudo nvidia-settings`
5. Turn on the nvidia whatever pipeline so there no screen tearing
6. Sound is absolute trash, not sure how to fix  