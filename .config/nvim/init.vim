set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" General Settings
source $HOME/.vimrc

" Plugin Configurations
source $HOME/.config/nvim/lua/plugins/config.lua
source $HOME/.config/nvim/lua/plugins/nvim-telescope.lua

" LSP Configurations
source $HOME/.config/nvim/lua/lsp/config.lua
