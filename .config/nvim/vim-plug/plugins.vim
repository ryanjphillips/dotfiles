"To do: REPLACE PATHS WITH Enviroment Variables"

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    "Language Server Protocal for NeoVim - Language Client
    Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

    " Ale Linter"
    Plug 'dense-analysis/ale'

    "C/C++ Language Server"
    "https://github.com/jacobdufault/cquery/wiki/Neovi"
    "Multi-entry selection UI. FZF
    
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    "Line Indentions - github.com/lukas-reinke/indent-blankline.nvim
    "Plug 'lukas-reineke/indent-blankline.nvim'

    "Markup for Note Taking
    Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim'
call plug#end()


"Language server settings and keybindings"

let g:LanguageClient_serverCommands = {
      \ 'javascript': ['typescript-language-server', '--stdio'],
      \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
      \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
      \ 'cuda': ['ccls', '--log-file=/tmp/cc.log'],
      \ 'objc': ['ccls', '--log-file=/tmp/cc.log'],
      \ }

" Automatically start language server"

let g:LanguageClient_autoStart = 1
let g:LanguageClient_autoStop = 1

"Keybindings"

nnoremap <leader>l :call LanguageClient_contextMenu()<CR>
nnoremap K :call LanguageClient#textDocument_hover()<CR>
nnoremap gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>r :call LanguageClient#textDocument_rename()<CR>

"Language Server Global Variables"

let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_virtualTextPrefix = ''
let g:LanguageClient_loggingFile =  expand('./lsc.log')
let g:LanguageClient_serverStderr = expand('./lsc.log')
let g:indent_blankline_show_end_of_line = v:true 
let g:indent_blankline_space_char_blankline = '|' 
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_show_current_context_start = v:true
let g:indent_blankline_char = '|'

"C/C++ Lang Server Config"

let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = '/home/ys/.config/nvim/settings.json'
let g:termdebug_use_prompt=1

"Ale Linter settings"
let b:ale_linters = {'javascript': ['eslint']}
