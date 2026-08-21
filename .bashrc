# Save changes first, then reload using "source ~/.bashrc"

# Custom Home Prompt (Replaces $HOME with )
export PS1="\[\e[38;5;110m\]\${PWD/#\$HOME/ } \[\e[m\]"

# Custom Aliases
alias dotfiles="cd ~/Git/dotfiles && nvim"
