# Setting up command completion.
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# Enabling vcs_info. 
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true 
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# zstyle ':vcs_info:*' formats '(%F{#F6F740}%b%f%u%c) '
zstyle ':vcs_info:*' formats '(%b%a%u%c) '
# Loading it before the prompt
precmd() {
    vcs_info 
}

# Setting up the prompt
#Default Prompt - DO NOT REMOVE
#PROMPT='%n@%m %1~ %% '
#PROMPT='%n@%m %1~ %% '
setopt prompt_subst
PROMPT='%F{#337CA0}%n%f@%F{#D4D2D5}%m%f %F{#8F98BA}%1~%f ${vcs_info_msg_0_}%% '

# dotfiles versioning command
# More information: https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
