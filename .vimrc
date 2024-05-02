set encoding=utf-8
scriptencoding utf-8
source /etc/vimrc


" -------------------- Function --------------------
let g:python_bin_dir = '~/python/bin'

" flake8
function! ExecuteFlake8()
    execute "!" . g:python_bin_dir . "/flake8 --extend-ignore=E266,E501" expand("%")
endfunction

" black
function! ExecuteBlack()
    execute "!" . g:python_bin_dir . "/black" expand("%")
endfunction

" isort
function! ExecuteIsort()
    execute "!" . g:python_bin_dir . "/isort --atomic" expand("%")
endfunction

" pytest
function! ExecutePytest()
    execute "!" . g:python_bin_dir . "/pytest -v" expand("%")
endfunction


" -------------------- Global --------------------
set nu
filetype plugin on

" バッファをsaveしていなくても切り替え可能にする
set hidden

" マウスを有効にする
set mouse=a

" 対になる文字を自動入力
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap { {}<LEFT>
inoremap ( ()<LEFT>
inoremap [ []<LEFT>

" バッファ切り替えのショートカット
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" ステータスライン
set laststatus=2
set statusline=%t%m%r%=[ENC=%{&fileencoding}][ROW=%l/%L][COL=%v]

" Leader
let mapleader = " "
" flake8
nnoremap <Leader>l :call ExecuteFlake8()<CR>
" black
nnoremap <Leader>b :call ExecuteBlack()<CR>
" isort
nnoremap <Leader>i :call ExecuteIsort()<CR>
" pytest
nnoremap <Leader>p :call ExecutePytest()<CR>
" 行頭にタブを挿入
nnoremap <Leader><TAB> mqI<TAB><ESC>`q

" Visualize
set listchars=tab:».,trail:_,nbsp:%
set list

" netrw
let g:netrw_sizestyle="H"
let g:netrw_timefmt="%Y/%m/%d %H:%M:%S"
let g:netrw_banner=0
let g:netrw_liststyle=1
let g:netrw_preview=1


" -------------------- Python --------------------
autocmd BufRead,BufNewFile *\.py\|*\.py_* set filetype=python
autocmd FileType python set expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType python set autoindent smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
" Leader-d でclass宣言行またはdef宣言行の一覧と行番号を表示
autocmd FileType python nnoremap <Leader>d !egrep -n 'class .*:\|def .*\(.*:' %


" -------------------- C --------------------
autocmd BufRead,BufNewFile *\.c\|*\.c_* set filetype=c
autocmd BufNewFile *\.c\|*\.c_* 0r ~/.vim/skeleton.c | 7
autocmd FileType c set expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType c set cindent
" '{' を入力すると自動で '}' も入力する
autocmd FileType c inoremap { {}<LEFT><CR><ESC><S-o>
" Leader-p で次の行に printf("\n"); を入力
autocmd FileType c nnoremap <Leader>p oprintf("\n");<ESC>4hi
" Leader-; で行末にセミコロンを入力
autocmd FileType c nnoremap <Leader>; mqA;<ESC>`q
