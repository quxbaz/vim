" Options
filetype on
filetype plugin on
filetype indent on

" set noeol
" set wrap linebreak textwidth=0
set autochdir
set backspace=indent,eol,start
if version > 702
  set cm=blowfish
endif
set fileformat=unix
set gdefault
set hidden
set history=200
set hlsearch
set ignorecase
set incsearch
set lazyredraw
set magic
set mouse=a  " Lets the scroll wheel work.
set mousehide
set noshowmatch
set nowrap
set number
set scrolloff=2
set showcmd
set showmode
set sidescroll=1
set sidescrolloff=10
set smartcase
set ssop=buffers,blank,curdir,folds,help,tabpages,winsize
set t_Co=256
set textwidth=0
set title
set virtualedit+=block
set vop=cursor,folds
set wildmenu
set wrapmargin=0

if &diff
  syntax off
else
  syntax on
endif

colorscheme mustang
set guifont=dejaVu\ sans\ mono\ 10

" Tab Config
set autoindent
set autoread
set expandtab
set shiftwidth=2
set smartindent
set tabstop=2

" Wildmenu completion

set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" MAPPINGS

" Basics
im <ESC>O <C-c>O
nn j gj
nn k gk
nn + <C-a>
nn - <C-x>
nn > mZ>>`Z2l
nn < mZ<<`Z2h
nn = ==
nn V mVV
nn c. ciw
nn d. daw
nn d_ mZ_d`Z
nn <C-o> mZO<C-c>`Z
nn O <C-c>O
nn <ESC>O <C-c>O
nn x "_x
nn yp yyp
nn yP yyP
vn . ip
vn <ESC> <C-c>
vn <S-k> <Nop>
nn <SPACE> ``
nn <C-e> 2<C-e>
nn <C-y> 2<C-y>
vn a <ESC>ggVG
nn <S-t> "zyykmZ"zP2jdd`Zk
nn <C-l> zz
vn <C-l> zz
nn <C-n> }
nn <C-p> {
vn <C-n> }
vn <C-p> {
" nn <C-b> <C-^>
nn t <C-^>
nn <C-b> <C-^>
" nn T :w<CR>
nn <CR> <C-t>
nn <M-f> za
nn H <C-w>p
nn L <C-w>w
" nn <C-h> "zx2h"zp
" nn <C-h> "zyl"zplxP
nn <silent> <C-h> mZvh"zyPhx2lx`Z
nn <INSERT> o<ESC>"+p==
" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

" Ex maps
let mapleader = ","
" nn <silent> T :w<CR>
" nn <silent> ,t :tabprev<CR>
nn <silent> <S-k> :noh<CR>
" nn <silent> ( mZ:s/\k*\%#\k*/(&)/e<CR>:noh<CR>`Zl
" vn <silent> ( :<C-u>%s/\%V\( *\)\(.*\%V.\)/\1(\2)/e<CR>:noh<CR>`>f)
" nn <silent> [ mZ:s/\k*\%#\k*/[&]/e<CR>:noh<CR>`Zl
" vn <silent> [ :<C-u>%s/\%V\( *\)\(.*\%V.\)/\1[\2]/e<CR>:noh<CR>`>f)
nn <silent> <TAB> :bn<CR>
nn <silent> <BACKSPACE> :bp<CR>
nn <silent> <Leader>c :set cursorcolumn!<CR>
" nn <silent> <Leader>t :w<CR>
" nn <silent> <Leader>t "zyykmZ"zP2jdd`Zk
" nn <silent> <Leader>e :E<CR>
nn <silent> <Leader>s :set spell!<CR>
nn <silent> <Leader>w :w<CR>
nn <silent> <Leader>v :tabe ~/.vimrc<CR>
nn <silent> <Leader>p :set paste!<CR>
nn <silent> <Leader>d :r!date +"\%a \%b \%d \%Y"<CR>

" Insert and command mode maps
no! <C-f> <RIGHT>
no! <C-b> <LEFT>
no! <C-a> <HOME>
no! <C-e> <END>
no! <C-d> <DELETE>
ino <C-k> <C-o>
ino <C-o> <C-c><S-o>

" Autocommands

" Jumps to the last edit point in the file.
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
au FileType clojure nn <silent> <buffer> ?? :call Clojure_doc()<CR>
au FileType html call Set_html()
au FileType css call Set_css()
au FileType java call Set_java()
au FileType sh call Set_sh()
au FileType matlab nn <buffer> ,e :!octave -q %<CR>
au FileType matlab nn <buffer> ,r :!octave -q % > /dev/null<CR>
au FileType tags set nowrap
au FileType tags nn <buffer> <CR> <C-]>
au FileType vim nn <silent> <buffer> ?? :call Vim_doc()<CR>
au BufNewFile,BufRead *.less set filetype=less
au BufNewFile,BufRead *.mako set filetype=html

function! Vim_doc()
  let cw =  string(expand("<cword>"))
  let cw = cw[1:strlen(cw)-2]
  exec ":h " . cw
endfunction

function Set_sh()
  nn <buffer> ,r :!clear;./%<CR>
  set tw=0
endfunction

function! Set_html()
  " Fix these, use sparkly magic if necessary.
  nn <buffer> <silent> <C-k> mZ:s/[^ ].\+/<!--&-->/e<CR>:noh<CR>`Z
  nn <buffer> <silent> <C-j> mZ:s/\(^ \)*<!--\(.*\)-->$/\1\2/e<CR>:noh<CR>`Z
  vn <buffer> <silent> <C-k> :s/[^ ].\+/<!--&-->/e<CR>:noh<CR>`>
  vn <buffer> <silent> <C-j> :s/\(^ \)*<!--\(.*\)-->$/\1\2/e<CR>:noh<CR>`>
endfunction

function! Set_css()
  " Fix these, use sparkly magic if necessary.
  nn <buffer> <silent> <C-k> mZ:s/[^ ].\+/\/*&*\//e<CR>:noh<CR>`Z
  nn <buffer> <silent> <C-j> mZ:s/\(^ \)*\/\*\(.*\)\*\/$/\1\2/e<CR>:noh<CR>`Z
  vn <buffer> <silent> <C-k> :s/[^ ].\+/\/*&*\//e<CR>:noh<CR>`>
  vn <buffer> <silent> <C-j> :s/\(^ \)*\/\*\(.*\)\*\/$/\1\2/e<CR>:noh<CR>`>
endfunction

" Looks up a term with the builtin Clojure docs.
function! Clojure_doc()
  " let cw =  string(expand("<cword>"))
  " let cw = cw[1:strlen(cw)-2]
  " exec "!clear;clj -e \"(doc " . cw . ")\""
endfunction

function! Set_java()
  nn <buffer> ,r :!clear;java %<<CR>
  nn <buffer> ,c :!clear;javac %<CR>
endfunction
