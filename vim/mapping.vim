"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map shortcut
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 按esc自动去除高亮
nnoremap <esc> :nohl<cr>

" chang to normal
tnoremap <silent> <Esc> <C-\><C-n>

nnoremap <silent><nowait> <C-l> gt
nnoremap <silent><nowait> <C-h> gT

cmap w!! w !sudo tee %
cmap w8 w ++enc=utf-8

" 开启或关闭 paste 模式
"nmap <leader>p :setlocal paste! paste?<cr>
set pastetoggle=<F2>

" terminal size
if has('nvim')
  set guicursor=
  nnoremap <silent><nowait> <space>t :<C-u>sp \| resize 7 \| term<CR>i
  nnoremap <silent><nowait> <space>tt :tabnew +term<CR>i
else
  " set ttyfast                " Faster redrawing.
  nnoremap <silent><nowait> <space>t :<C-u> sp \| resize 7 \| term ++curwin<CR>
  nnoremap <silent><nowait> <space>tt :<C-u>tabnew \| term ++curwin<CR>
endif

" * 搜索不调整到下一个
nnoremap * *``
nnoremap * :keepjumps normal! mi*`i<CR>

" Reselect visual block after indent/outdent.调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

" Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" confirm selection in the command line mode for wildmenu
cnoremap <expr> <space>  wildmenumode()?"\<space>\<BS>":"\<space>"
