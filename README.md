# .dotfiles

This dotfiles directory is managed with GNU stow.
To install a package, run
```sh
stow [package name]
```

The program will be run with `--dotfiles` and `--no-folding` options, that are specified in .stowrc file.
`--dotfiles` is required to transform "dot-" prefixes into actual dots in filenames, while `--no-folding` is just my personal preference.
