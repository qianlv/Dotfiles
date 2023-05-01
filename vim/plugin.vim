call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'
" Plug 'uarun/vim-protobuf'
Plug 'itchyny/lightline.vim'
Plug 'honza/vim-snippets'
Plug 'Yggdroot/indentLine'
Plug 'frazrepo/vim-rainbow'
Plug 'liuchengxu/vista.vim'
Plug 'numToStr/FTerm.nvim'
Plug 'justinmk/vim-sneak'
" Plug 'liuchengxu/vim-which-key'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" coc extensions
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
" CocInstall coc-snippets coc-lists coc-ecdict coc-calc coc-sh
" coc-rust-analyzer coc-pyright coc-json coc-pairs coc-clangd coc-word
" coc-marketplace coc-html
"
" C++ Project
" cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1
" or
" https://github.com/nickdiego/compiledb
" pip install compiledb
" compiledb make
" or
" bear, https://github.com/rizsotto/Bear

" Themes
" Plug 'morhetz/gruvbox'
" Plug 'ellisonleao/gruvbox.nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/everforest'
Plug 'sainnhe/sonokai'
Plug 'projekt0n/github-nvim-theme'
Plug 'xiyaowong/nvim-transparent'

if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

    Plug 'github/copilot.vim'

    let g:copilot_filetypes = {'markdown': v:true}
endif

Plug 'Shirk/vim-gas', {'for': 'gas'}    " GNU assembly syntax highlight
" " Initialize plugin system
call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ColorScheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Important!!
if has('termguicolors')
  set termguicolors
endif

" For dark version.
set background=dark

" Set contrast.
" This configuration option should be placed before `colorscheme gruvbox-material`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_foreground = 'mix'
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_better_performance = 1
let g:gruvbox_material_ui_contrast = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_diagnostic_text_highlight = 1
let g:gruvbox_material_diagnostic_line_highlight = 1
let g:gruvbox_material_diagnostic_virtual_text = 'colored'
colorscheme gruvbox-material

" Available values: 'hard', 'medium'(default), 'soft'
" let g:everforest_background = 'hard'
" let g:everforest_better_performance = 1
" colorscheme everforest

" The configuration options should be placed before `colorscheme sonokai`.
" let g:sonokai_style = 'espresso'
" let g:sonokai_better_performance = 1
" let g:sonokai_enable_italic = 1
" let g:sonokai_diagnostic_text_highlight = 1
" let g:sonokai_diagnostic_line_highlight = 1
" let g:sonokai_diagnostic_virtual_text = 'colored'
" colorscheme sonokai


""""""""""""""""""""""""""""""
" for coc
""""""""""""""""""""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <C-n>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gs :sp<CR><Plug>(coc-definition)
nmap <silent> gv :vsp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>ar  <Plug>(coc-codeaction-selected)
nmap <leader>ar  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Header/File switch
command! -nargs=0 SH   :call     CocAction('runCommand', 'clangd.switchSourceHeader')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>a  :<C-u>CocList --normal diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>
" Buffer List
nnoremap <silent><nowait> <leader>ls  :<C-u>CocList buffers<cr>
" Do default action for next item.
" nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>re  :<C-u>CocListResume<CR>
" Search files
nnoremap <silent><nowait> <leader>p  :<C-u>CocList files<CR>
" Restar Coc
nnoremap <silent><nowait> <leader>rs  :<C-u>CocRestart<CR>
" Open CocConfig
nnoremap <silent><nowait> <leader>cf  :<C-u>CocConfig<CR>

" enable/disable coc integration
let g:airline#extensions#coc#enabled = 1

" install ripgrep
" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <Leader>gr :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_next = '<Tab>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'


""""""""""""""""""""""""""""""
" nerdcommenter
""""""""""""""""""""""""""""""
" 注释的时候自动加个空格, 强迫症必配
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDAltDelims_python = 1
" Align line-wise comment delimiters flush left instead of following code IndentationError
let g:NERDDefaultAlign = 'left'
nmap <silent><nowait> <Enter>   <plug>NERDCommenterToggle
xmap <silent><nowait> <Enter>   <plug>NERDCommenterToggle
let g:NERDCustomDelimiters = { 'gas' : {'left': '#'}}


""""""""""""""""""""""""""""""
" IndentLine
""""""""""""""""""""""""""""""
let g:indentLine_char = "┆"
let g:indentLine_enabled = 1
let g:autopep8_disable_show_diff=1

""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
nmap <leader>tr :NERDTree<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-rainbow
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" let g:lightline = {'colorscheme' : 'sonokai'}
let g:lightline = {'colorscheme' : 'gruvbox_material'}
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'relativepath', 'cocstatus', 'currentfunction', 'modified'] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction',
      \ },
      \ }

" let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
" let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
" let s:palette.inactive.middle = s:palette.normal.middle
" let s:palette.tabline.middle = s:palette.normal.middle

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vista
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
  \ 'cpp': 'coc',
  \ 'c': 'coc',
  \ 'py': 'coc'
  \ }

" load lua config
if has('nvim')
lua <<EOF

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
map('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)


------------------------------------------------------
-- treesitter
------------------------------------------------------
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = {
      "c", "cpp", "vim", "lua", "rust",
      "python", "markdown", "racket", "bash", "java",
      "make", "json", "jsonc", "scheme",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {"c", "cpp", "rust"},
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false
  },
}

-- folder config
vim.opt.foldlevel = 2
vim.opt.foldmethod = "manual"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

require("FTerm").setup({
    ---Filetype of the terminal buffer
    ---@type string
    ft = 'FTerm',

    border = 'rounded',

    -- Highlight group for the terminal. See `:h winhl`
    hl = 'Normal',

    -- Transparency of the floating window. See `:h winblend`
    blend = 0,
    dimensions  = {
        height = 0.8,
        width = 0.85,
    },
})

require("transparent").setup({
  extra_groups = { -- table/string: additional groups that should be cleared
    -- In particular, when you set it to 'all', that means all available groups
    "FloatBorder", -- for floating windows

    -- example of akinsho/nvim-bufferline.lua
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",
  },
  exclude_groups = {
    "LineNr",
    -- "CursorLineNr",
  }, -- table: groups you don't want to clear
})
vim.g.transparent_enabled = true

EOF
endif
