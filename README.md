## Dotfiles

### Steps

#### 1. Installing

##### MacOS

```sh
brew install git
brew install stow
```

##### Linux

```sh
sudo apt install git stow
```

#### 2. Clone the repo

This must be cloned in the $HOME directory

```sh
git clone git@github.com:xsmyile/dotfiles.git
```

#### 3. STOW!

There are two kinds of content here, deployed differently. The root-level dotfiles
(`.zshrc`, `.bashrc`, `.bash_profile`, `.vimrc`) ship as a single package, and each
app directory ships as its own:

```sh
cd dotfiles
stow .                                              # root-level dotfiles
stow nvim tmux ghostty git lazygit ngrok searxng    # per-app packages
```

`brew/` is never stowed -- it holds the Brewfile and its dump script, referenced by
absolute path.

Because `stow .` treats the repo root as one package, every package directory must be
listed in `.stow-local-ignore`; otherwise `stow .` creates dead symlink trees at
`~/nvim`, `~/tmux` and so on. Add a matching `^/<name>$` line when you add a package.

```sh
stow -D <package>                                   # remove one package
stow -n -v <package>                                # dry run
```

### SearXNG

Personal SearXNG Docker setup, following the latest images. See
[setup, migration and update instructions](searxng/README.md).

### Resources

https://www.gnu.org/software/stow/
