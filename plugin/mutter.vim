" mutter.vim
"   Written by David Yeung
"
" Simple, flexible commenting utility.
"
" INSTRUCTIONS
"
" To comment a line or group of lines, press ctrl-k.
" To uncomment a line or group lines, press ctrl-j.
" To change the shortcut keys, see #SHORTCUTS below.
" To extend this plugin for a language not specified here, see #EXTEND below.
"
" TODO
" Move the cursor left or right by the length of the comchar (comment
" character) after commenting.
"

if exists("b:commenter")
  finish
endif

let b:commenter = 1
let b:comstr = ""

autocmd BufEnter * call SetCommentString()

" #SHORTCUTS
" Edit these lines if you want to change the hotkeys.
nn <silent> <C-k> mZ:call LineComment()<CR>`Z
nn <silent> <C-j> mZ:call LineUncomment()<CR>`Z
vn <silent> <C-k> :call LineComment()<CR>`>
vn <silent> <C-j> :call LineUncomment()<CR>`>

function! LineComment()
  exe 's/\v^( *)(' . b:comstr . '| )*(.)/\1' . b:comstr . ' \3/e'
endfunction

function! LineUncomment()
  exe 's/\v^( *)(' . b:comstr . '| )*/\1/e'
endfunction

function! BlockComment()
endfunction

" #EXTEND
" Edit this line to allow commenting for your language. Specify the comment
" char on the left and the language on the right. Make sure to escape special
" characters like '%' and '/'.
let s:comstrings = {
\   '#' : "conf,python,ruby,sh",
\   ';' : "asm,clojure,lisp,scheme",
\   '\%' : "matlab",
\   '"' : "vim",
\   '\/\/' : "c,cpp,java,javascript,processing,php"
\ }

function! SetCommentString()
  "autocmd! BufEnter * call SetCommentString()
  for k in keys(s:comstrings)
    if match(s:comstrings[k], '\<' . &ft . '\>') != -1
      let b:comstr = k
      return
    endif
  endfor
  let b:comstr = "#"
endfunction
