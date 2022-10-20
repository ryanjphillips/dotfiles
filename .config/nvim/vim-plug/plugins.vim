"To do: REPLACE PATHS WITH Enviroment Variables"

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
     
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'

    " Ale Linter"
    Plug 'dense-analysis/ale'

    let b:ale_linters = {'javascript': ['eslint']}

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




set completeopt=menu,menuone,noselect

lua <<EOF
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
EOF
