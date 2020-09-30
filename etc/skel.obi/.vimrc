" Configuration file for vim
" vim:expandtab:foldmethod=marker:foldlevel=0:tw=0

" fix ui language
set langmenu=en_US.UTF-8

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" -----------------------------------------------------------
"Set Path
set runtimepath+=~/.vim
" all folds should be closed
" open the folds with: zo / zR

"ale
"let g:ale_completion_enabled = 1
"let g:deoplete#enable_at_startup = 1

"enable pathogen plugin
if filereadable(expand("~/.vim/autoload/pathogen.vim"))
    runtime! autoload/pathogen.vim
    if exists("g:loaded_pathogen")
       execute pathogen#infect()
    endif
endif

" -----------------------------------------------------------
" Set Standard Behaviour

" also match '<' and '>' as brackets
set matchpairs+=<:>

" Use Vim defaults instead of 100% vi compatibility
set nocompatible
set showmode
let mapleader = ","

" more powerful backspacing
set backspace=indent,eol,start
set matchtime=2         "the default is 5

" default: enabled for user and disabled for root:)
" enable modelines --  alias vim-ml='vim "+set ml"'  -- in your .bashrc
" set nomodeline

" set verbose=5
filetype on
filetype plugin on
filetype indent on

"" ENCODING OPTIONS
set fileencodings=ucs-bom,utf-8,default
set encoding=utf8

"" TABS AND INDENT
set expandtab
set tabstop=4           "length of a hard tab
set softtabstop=4       "number of chars when you press tab
set tabpagemax=100

"" INDENT
set shiftwidth=4        "length of std indent
set autoindent          " always set autoindenting on
"set smartindent
"set cinoptions=>s,e0,n0,f0,{0,}0,^0,L-1,:s,=s,l0,b0,gs,hs,ps,ts,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j0,J0,)20,*70,#0
set cinoptions=>s,e0,n0,f0,{0,}0,^0,Ls,:s,=s,l1,b0,gs,hs,N0,E0,ps,t0,is,+s,c3,C0,/0,(2s,us,U1,w0,W0,k0,m0,M0,j0,J0,)100,*200,#0

"" SPLITS
set splitbelow
set splitright

"" LINES
set nowrap
set linebreak            " Don't wrap words by default
set textwidth=0          " Don't wrap lines by default

" do not insert two spaces after each period on joined lines
set nojoinspaces

" SEARCH
set ignorecase           " Do case insensitive matching
set smartcase            " Be sensitive when there is a capital letter
"set incsearch           " Incremental search
set gdefault             " Set 'g' substitute flag on.

" SAVE & BACKUP
set autowrite            " Automatically save before commands like :next and :make
set nobackup             " Don't keep a backup file
set dir=~/.vim/directories/swap       " swap directory
set backupdir=~/.vim/directories/backup
set viewdir=~/.vim/directories/views

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='20,\"100,:20,%,n~/.vim/directories/info
"set history=50           " keep 50 lines of command line history

"" Folding
set foldmethod=indent
set foldlevel=99

"Viki

let g:vikiOpenUrlWith_mailto = 'thunderbird -compose %{URL}'
let g:vikiOpenUrlWith_html   = "silent !firefox %{URL}"
let g:vikiOpenUrlWith_ANY    = "silent !firefox %{URL}"
let g:vikiOpenFileWith_html  = "silent !firefox %{FILE}"
let g:vikiOpenFileWith_ANY   = "silent !start %{FILE}"

" -----------------------------------------------------------
" GUI / WINDOWS / MAC

set guifont=DejaVu\ Sans\ Mono\ Bold\ 16
if has('win32')
    language messages en_US.UTF-8
    set encoding=utf8
    set langmenu=en_US.UTF-8
    set guioptions-=m "remove menu bar
    set guioptions-=T "remove toolbar
    set guioptions-=r "remove right-hand scroll bar
    set guioptions-=L "remove left-hand scroll bar
    set guifont=DejaVu_Sans_Mono:h16:b:cANSI
    set runtimepath+=~/_vim
    set dir=~/_vim_swp
    set viewdir=~/_vim_view
    set backupdir=~/_vim_backup
    set viminfo='20,\"100,:20,%,n~/_viminfo
elseif has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        set encoding=utf8
    endif
    "enable 256 colors for airline
    "set t_Co=256
endif

" -----------------------------------------------------------
" Set Standard Appearance


syntax on           " enables syntax highlighting by default.
"set list           " show invisible cahrs
set listchars=nbsp:⋅,tab:→⋅,eol:¶,trail:⋅,extends:»,precedes:« " Unprintable chars mapping
set number          " show line numbers
set ruler           " show the cursor position all the time
set ruf=%55([%{&ff}]\ %y\ [%{&encoding}]\ %t\ [%c]%v,%l\ %L\ %P\ #%n%)
set showmode        " show current mode
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set hlsearch        " hilight searched stuff
set vb t_vb=        " disable visual bell
"set colorcolumn=81

" Set the command line to one line high.
" set cmdheight=1

" Always display a status line at the bottom of window.
"set laststatus=2

" Scroll when 2 lines before bottom of the terminal
set scrolloff=2
set sidescroll=4

"splitting
set splitbelow
set splitright

" -----------------------------------------------------------
" COLOR SETTING


" Colors
" 0 darkgrey
" 1 red
" 2 green
" 3 yellow
" 4 blue
" 5 magenta/pink
" 6 cyan
" 7 white



" THIS MUST HAPPEN BEFORE COLORSCHEME IS SET
" Set Whitespace Color!

augroup alleFarben
    au!
    " :autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    " The following alternative may be less obtrusive.
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
    " Try the following if your GUI uses a dark background.
    " :autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

    "Color Folds
    autocmd ColorScheme * highlight Folded     ctermbg=darkgrey ctermfg=white
    autocmd ColorScheme * highlight FoldColumn ctermbg=darkgrey ctermfg=white
    autocmd ColorScheme * highlight Folded     guibg=darkgrey   guifg=white
    autocmd ColorScheme * highlight FoldColumn guibg=darkgrey   guifg=white

    "Color Column
    autocmd ColorScheme * highlight ColorColumn ctermbg=lightblue guibg=lightblue

    "indent_guides_colors
    let g:indent_guides_auto_colors = 0
    if &term =~ "xterm"
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=8
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=0
    else
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=8
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=0
    endif

    " Better Menu Colors
    autocmd ColorScheme *  highlight   Pmenu         guifg=darkgray  guibg=darkgreen  ctermfg=0 ctermbg=2
    autocmd ColorScheme *  highlight   PmenuSel      guifg=darkgray  guibg=white      ctermfg=0 ctermbg=7
    autocmd ColorScheme *  highlight   PmenuSbar     guifg=white     guibg=darkgray   ctermfg=7 ctermbg=0
    autocmd ColorScheme *  highlight   PmenuThumb    guifg=darkgray  guibg=white      ctermfg=0 ctermbg=7

    "Spell
    autocmd ColorScheme *  highlight   SpellBad      term=reverse ctermbg=1 ctermfg=white gui=undercurl guisp=Red

    "Diff
    autocmd ColorScheme *  highlight   DiffAdd       ctermbg=green ctermfg=LightGray
    autocmd ColorScheme *  highlight   DiffDelete    ctermbg=DarkRed ctermfg=LightGray
    autocmd ColorScheme *  highlight   DiffChange    ctermbg=Yellow ctermfg=black
    autocmd ColorScheme *  highlight   DiffText      ctermbg=Yellow ctermfg=black cterm=reverse
augroup END


"Set the color Scheme
if has("gui_running")
    colorscheme desert
else
    colorscheme default
endif

" Viki
let g:vikiFancyHeadings=1

" listchar background
"highlight SpecialKey term=underline ctermbg=4 ctermfg=7
"hi SpecialKey term=bold        ctermbg=0 ctermfg=3
"hi NonText    term=bold        ctermbg=4 ctermfg=0



" -----------------------------------------------------------
" SYNTAX SETTING

let c_space_errors = 1      "cspace erros

call matchadd("todo","Note")
call matchadd("todo","TODO")
call matchadd("todo","OBI")
call matchadd("todo","BUG")
call matchadd("todo","FIX")
call matchadd("todo","FIXME")
call matchadd("todo","BADCODE")
call matchadd("todo","MOREDOC")
call matchadd("todo","XXX")

" ----
" WhiteSpaces
augroup WhiteSpaces
    autocmd!

    " Show trailing whitespace:
    ":match ExtraWhitespace /\s\+$/

    " Show trailing whitepace and spaces before a tab:
    autocmd BufReadPost,BufNewFile * :match ExtraWhitespace /\s\+$\| \+\ze\t/

    " Show tabs that are not at the start of a line:
    ":match ExtraWhitespace /[^\t]\zs\t\+/

    " Show spaces used for indenting (so you use only tabs for indenting).
    ":match ExtraWhitespace /^\t*\zs \+/

    " Switch off :match highlighting.
    ":match

    "If you do not understand - it is not meant for you:P
    ":match ExtraWhitespace /\s\+\%#\@<!$/
    ":match ExtraWhitespace / \+\ze\t/
    ":syn match ExtraWhitespace /\s\+$/ contained
    ":nnoremap <Leader>wf :match Normal         /^\s* \s*\<Bar> \s\+\%#\@<!$<CR>
    ":syn match ExtraWhitespace ~^\s\s\+~
    ":match ExtraWhitespace ~\s\+$~
    ":match ExtraWhitespace ~\( \+\ze\t\)\|\(\s\+\%#\@<!$\)~

    " Show leading whitespace that includes spaces, and trailing whitespace.
    ":autocmd BufWinEnter * syn match ExtraWhitespace /^\s* \s*\|\s\+$/

    " -----
augroup END "WhiteSpaces



" -----------------------------------------------------------
" Language and Spellchecking

"if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
"    set fileencodings=utf-8
"endif
"

let g:spellfile_URL = "http://ftp.vim.org/pub/vim/runtime/spell/"

" enable/disable spellcheck in different languages
"map ,spus :setlocal spell spelllang+=en_US<CR>
"map ,spgb :setlocal spell spelllang+=en_GB<CR>

"" It should work like this but it does not
"command Spe :setlocal spell spelllang=en
"command Spd :setlocal spell spelllang=de_de
"command Spn :setlocal spell spelllang=""
"set spellfile="de.utf-8.add,en.utf-8.add"

command Spe :set spell spelllang=en    | set spellfile="~/.vim/spell/en.utf-8.add"
command Spd :set spell spelllang=de_de | set spellfile="~/.vim/spell/de.utf-8.add"
command Spn :set spell spelllang=""

let spell_root_menu = '-'
let spell_auto_type = 'none'
let spell_insert_mode = 0
" disable guessing of language:
let spell_guess_language_ft = ""
" list of known-good words for spell-checking:
set spellfile="~/.vim/spell/de.utf-8.add,~/.vim/spell/en.utf-8.add"

:setlocal spell spelllang=""
"  let spell_auto_type="tex,doc,mail,txt"
"  let spell_auto_type="none"
"  let spell_guess_language_ft = "none"
"  let spell_language_list = "ngerman,american"
"  let spell_update_time = 2000
"  nnoremap <silent> <F11> :SpellAutoDisable<CR>



" -----------------------------------------------------------
" AutoCommands

if has("autocmd")
    augroup filetypes
        au!
        "auto source .vimrc
        "autocmd BufWritePost .vimrc source %
        au BufReadPre  *vimrc setl foldmethod=marker
        au BufReadPre  *vimrc setl foldlevel=0

        au BufReadPost,BufNewFile /usr/include/c++/* setl filetype=cpp
        au BufReadPost,BufNewFile /usr/local/include/c++/* setl filetype=cpp
        au BufReadPost,BufNewFile /usr/opt/gcc_trunk_install/include/c++/* setl filetype=cpp
        au BufReadPost,BufNewFile */include/c++/* setl filetype=cpp
        au BufReadPost,BufNewFile */include/c/* setl filetype=cpp
        au BufReadPost,BufNewFile /usr/local/include/ycmd/* setl filetype=cpp
        au BufReadPre  *.nfo  setl fileencodings=cp437
        au BufReadPre  /etc/sudoers.d/* setl syntax=sudoers
        au BufReadPre  /usr/share/vim/* if exists('&cc') | setl cc= | endif
        au BufReadPre  ~/.vim* if exists('&cc') | setl cc= | endif

        au BufReadPost,BufNewFile   *.viki setl filetype=viki
        au BufReadPost,BufNewFile   *.viki let g:vikiFancyHeadings=1
        au BufReadPost              *.viki let @/ = "TODO"

        "au BufReadPost,BufNewFile   /home/oberon_daten/daten/viki/* setl filetype=viki
        au BufReadPost,BufNewFile   /home/oberon_daten/daten/viki/* let g:vikiFancyHeadings=1
        au BufReadPost              /home/oberon_daten/daten/viki/* let @/ = "TODO"

        au BufReadPost,BufNewFile   /mnt/crypt/oberon/viki/* let g:vikiFancyHeadings=1
        au BufReadPost              /mnt/crypt/oberon/viki/* let @/ = "TODO"


        au filetype viki    VxFoldViki
    augroup END

    augroup programming
        au!
        au filetype c,cpp    setl nowrap
        au filetype c,cpp    setl foldlevelstart=99
        au filetype c,cpp    setl foldmethod=syntax
        au filetype c,cpp    setl expandtab
        au filetype c,cpp    filetype indent on

        au filetype python   filetype indent on
        au filetype python   setl expandtab
        au filetype python   setl list
        au filetype python   setl foldlevelstart=99
        au filetype python   setl foldmethod=indent
        au filetype python   call IndentGuidesEnableObi()
        "au filetype python  setl omnifunc=pysmell#Complete
        "au filetype python   setl omnifunc=pythoncomplete#Complete
        "jedi-vim
        au filetype python   setl completeopt-=preview
        au filetype python   noremap <LEADER>b :!python %<CR>

        au filetype make setl noexpandtab
        au filetype make setl list

        au filetype haskell  setl expandtab

        "bash
        au filetype sh       filetype indent on
        au BufReadPre  /tmp/bash-fc* setl syntax=sh
        au BufReadPre  ~/.bash* setl syntax=sh
        au BufReadPre  ~/.bash* setl foldmethod=manual
        au BufReadPre  /home/oberon/.bash* setl syntax=sh
        au BufReadPre  /home/oberon/.bash* setl foldmethod=marker

        "javascript
        au filetype javascript setl expandtab
        au filetype javascript setl list
        au filetype javascript setl tabstop=2
        au filetype javascript setl softtabstop=2

        "gradle
        au BufNewFile,BufRead *.gradle set filetype=groovy
    augroup END

    augroup man
        au!
        au filetype man  setl readonly
        au filetype man  if exists('&cc') | setl cc= | endif
        au filetype man  nmap <buffer> q :quit<CR>
        "au filetype man runtime! macros/less.vim    -- bad because mappings become global
        "au filetype man  nmap <buffer> <Up> <C-Y>
        "au filetype man  nmap <buffer> <Down> <C-E>
        au filetype man  noremap <buffer> <Space> <PageDown>
        au filetype man  nmap <buffer> <Home> gg
        au filetype man  nmap <buffer> <End> G
        au filetype man  nmap <buffer> K <C-]>
        au filetype man  nmap <buffer> K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>
    augroup END

    augroup mail
        au!
        "au filetype mail setl tw=72
        "au filetype mail setl formatoptions+=a
        au filetype mail setl nomodeline
        au filetype mail setl list
        " use ,, to reforma:t mails to something useful
        au filetype mail  map ,,      :set tw+=2<cr>gqip
        au filetype mail vmap ,, <Esc>:set tw+=2<cr>gvgqgv
    augroup END

    augroup resCur
        autocmd!
        if has("folding")
            autocmd BufWinEnter * if ResCur() | call UnfoldCur() | endif
        else
            autocmd BufWinEnter * call ResCur()
        endif
    augroup END

    augroup more
        autocmd!
        " turn off vbell in gui
        autocmd GUIEnter * :set vb t_vb=
        " setl backup ext
        autocmd BufWritePre * let &bex = '-' . strftime("%F_%R") . '.bak'
        " delete white spaces for some exts
        autocmd FileType c,cpp,sh,purescript,python autocmd BufWritePre <buffer> %s/\s\+$//e
        ""autocmd FileType c,cpp,sh autocmd BufEnter <buffer> %s/\s\+$//e
    augroup END

    " Some Debian-specific things
    augroup filetypes
        "au BufRead reportbug.*      setl ft=mail
        "au BufRead reportbug-*      setl ft=mail
    augroup END

endif " has ("autocmd")



" -----------------------------------------------------------
" Functions


" toggle color column
fu Obi_Col_Toggle()
    if exists('&cc')
        if &cc != ""
            setl cc=
        else
            let s:col1 = virtcol('.')
            if s:col1 < 2
                setl cc=81
            else
                let s:col1 = s:col1 - 1
                let s:col2 = s:col1 + 82
                let &cc=s:col1 . "," . s:col2
            endif
        endif
    endif
endf

" open links in browser
function! Browser ()
   let s:line = getline (".")
   let s:line = matchstr (s:line, "http[^   ]*")
   silent execute  "! [[ $UID -ne 0 ]] && firefox -new tab ".s:line  "&"
   redraw!
endfunction

" try only to enable indent guides when avilable
fu IndentGuidesEnableObi()
    if exists(":IndentGuidesEnable")
        :IndentGuidesEnable
    endif
endf

" restoring sessions
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

if has("folding")
  function! UnfoldCur()
    if !&foldenable
      return
    endif
    let cl = line(".")
    if cl <= 1
      return
    endif
    let cf  = foldlevel(cl)
    let uf  = foldlevel(cl - 1)
    let min = (cf > uf ? uf : cf)
    if min
      execute "normal!" min . "zo"
      return 1
    endif
  endfunction
endif

" ----
command Mpro    call Obi_Pro()
command Mnopro  call Obi_No_Pro()
command Minvpro call Obi_Toggle_Pro()

fu Obi_Toggle_Pro()
    if exists('s:obi_pro_toggle')
        call Obi_No_Pro()
    else
        call Obi_Pro()
    endif
endf

fu Obi_Pro()
    let s:obi_pro_toggle="toggle on"
    map! ö [
    map! ä ]
    map! Ö {
    map! Ä }
    map ö [
    map ä ]
    map Ö {
    map Ä }
endf

function Obi_No_Pro()
    if exists('s:obi_pro_toggle')
        unlet s:obi_pro_toggle
        iunmap ö
        iunmap ä
        iunmap Ö
        iunmap Ä
        cunmap ö
        cunmap ä
        cunmap Ö
        cunmap Ä
    endif
endfunction

"http://docwhat.org/vim-preserve-your-cursor-and-window-state/

"" TODO
" osse | use getpos('w0') instead of normal H and getpos('.')
" osse | obiwahn: actually, look into winsaveview() :O

function! Preserve(command)
  " Save the last search
  let last_search=@/
  " Save the current cursor position
  let save_cursor = getpos(".")
  " Save the window position
  normal H
  let save_window = getpos(".")
  call setpos('.', save_cursor)

  " Do the business:
  execute a:command

  " Restore the last_search
  let @/=last_search
  " Restore the window position
  call setpos('.', save_window)
  normal zt
  " Restore the cursor position
  call setpos('.', save_cursor)
endfunction

command! -bar SudoWrite :
      \ setlocal nomodified |
      \ exe (has('gui_running') ? '' : 'silent') 'write !sudo dd of=%' |
      \ let &modified = v:shell_error





" -----------------------------------------------------------
" Code Snippets - with key binding prefixed by ,

map ,re  o<CR>Regards!<CR><CR>  Jan Christoph Uhde<ESC>
map ,mfg o<CR>Mit freundlichen Gruessen<CR><CR>  Jan Christoph Uhde<ESC>
map ,gr  o<CR>gruesse<CR><CR>  Obi<ESC>



" -----------------------------------------------------------
" KeyMapping and Commands


" ---- Commands
"edit vim
nnoremap <leader>ev :<C-u>:vsplit $MYVIMRC<CR>
"source vim
nnoremap <leader>sv :<C-u>:source $MYVIMRC<CR>
"surrond with quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
"surrond with quotes
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" set Y to a saner default
map Y 0y$
" Clipboard for Dummies:P
command Paste :set paste | :put + | :set nopaste
"map <leader>p :Paste<CR>
command -range Copy  :<line1>,<line2>yank +
"map <leader>c :Copy<CR>

"set textwidth
command T0 :setl textwidth=0 | :setl nowrap | :setl tw
command -nargs=1 T  :setl textwidth=<args> | :setl nopaste | :setl wrap | :setl tw
"set textwidth and reformat
"command -nargs=1 TW :set textwidth=<args> | :set nopaste | :set wrap | :normal! "<ESC>gg|gqG" | :set tw

"pylint binding
command Pylint :new | silent r!pylint # <CR>
map <silent> <leader>pylint :new \| silent r!pylint # <CR>

"Voom
command Vo :exe "Voom ".&ft
"let g:voom_tab_key="<F7>"

" ---- Important Mappings!!!
" escape insert with jj matchtime should be reduced to 1
" inoremap jj <Esc>

" moving splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Prompt for a command to run
map <Leader>tp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>tl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>ti :VimuxInspectRunner<CR>
" Zoom the tmux runner pane
map <Leader>tz :VimuxZoomRunner<CR>


" CTRL-C shortcuts
noremap <silent><C-C>n :set invnumber <CR>
noremap <silent><C-C>l :set invlist <CR>
noremap <silent><C-C>w :set invwrap <CR>
noremap <silent><C-C>i :IndentGuidesToggle <CR>
noremap <silent><C-C>H :set invhls <CR>
noremap <silent><C-C>h :nohls <CR>
noremap <silent><C-C>c :call Obi_Col_Toggle()<CR>
noremap <silent><C-C>b :call Browser()<CR>

" tabs
noremap  <silent><F1>      :tabprevious<CR>
noremap! <silent><F1> <C-O>:tabprevious<CR>
noremap  <silent><F2>      :tabnext<CR>
noremap! <silent><F2> <C-O>:tabnext<CR>
noremap  <silent><F3>      :wincmd h<CR>
noremap! <silent><F3> <C-O>:wincmd h<CR>
noremap  <silent><F4>      :wincmd l<CR>
noremap! <silent><F4> <C-O>:wincmd l<CR>

" :bn :bp
noremap  <silent><C-F1>      :bp<CR>
noremap! <silent><C-F1> <C-O>:bp<CR>
noremap  <silent><C-F2>      :bn<CR>
noremap! <silent><C-F2> <C-O>:bn<CR>
noremap  <silent><C-F3>      :b#<CR>
noremap! <silent><C-F3> <C-O>:b#<CR>
noremap  <silent><C-F4>      :buffers<CR>
noremap! <silent><C-F4> <C-O>:buffers<CR>
noremap  <silent><C-C><F1>      :bp<CR>
noremap! <silent><C-C><F1> <C-O>:bp<CR>
noremap  <silent><C-C><F2>      :bn<CR>
noremap! <silent><C-C><F2> <C-O>:bn<CR>
noremap  <silent><C-C><F3>      :b#<CR>
noremap! <silent><C-C><F3> <C-O>:b#<CR>
noremap  <silent><C-C><F4>      :buffers<CR>
noremap! <silent><C-C><F4> <C-O>:buffers<CR>



"goto tag
noremap  <F5>      :YcmCompleter GoTo<CR>
noremap! <F5> <C-O>:YcmCompleter GoTo<CR>

"new tab
noremap  <C-F5> :tabnew<CR>
noremap! <C-F5> <C-O>:tabnew<CR>
noremap! <C-C><F5> <C-O>:tabnew<CR>

"tags
noremap  <F6> <C-]>
noremap! <F6> <C-]>
noremap <C-F6> :TagsGenerate!<CR>
noremap <C-C><F6> :TagsGenerate!<CR>

" F7 is used for snipmate -- insert mode
noremap <F7> :make<CR>

" kill whitespace at end of line: keep search register!!!
"noremap <silent> <F8> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
"noremap! <silent> <F8> <ESC>:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>i
noremap  <F8>      :call Preserve("%s/\\s\\+$//e")<CR>
noremap! <F8> <C-o>:call Preserve("%s/\\s\\+$//e")<CR>

set pastetoggle=<F9>

let no_toggle_mouse_maps=1
noremap  <F10>      :call ToggleMouse()<CR>
noremap! <F10> <C-O>:call ToggleMouse()<CR>

nnoremap <silent> <F11> :vertical resize +2<CR>
nnoremap <silent> <F12> :vertical resize -2<CR>
nnoremap <silent> <C-F11> :resize +2<CR>
nnoremap <silent> <C-F12> :resize -2<CR>
nnoremap <silent> <C-C><F11> :resize +2<CR>
nnoremap <silent> <C-C><F12> :resize -2<CR>

" open close folds
noremap <silent> <LEADER>3  :set foldlevel=0 <CR>
noremap <silent> <LEADER>4  :set foldlevel=1 <CR>
noremap <silent> <LEADER>5  :set foldlevel=2 <CR>
noremap <silent> <LEADER>6  :set foldlevel=3 <CR>
noremap <silent> <LEADER>7  :set foldlevel=4 <CR>
noremap <silent> <LEADER>8  :set foldlevel=5 <CR>
noremap <silent> <LEADER>9  :set foldlevel=6 <CR>
noremap <silent> <LEADER>0  :set foldlevel=7 <CR>
noremap <silent> <LEADER>`  zR <CR>
noremap <silent> <LEADER>1  zo <CR>
noremap <silent> <LEADER>2  zc <CR>

"paste
noremap  <silent> <LEADER>p       :set pastetoggle<CR>
noremap  <silent> <LEADER>c       :set paste<BAR>:norm! "+p<BAR>:set nopaste<CR>
norema   <silent> <LEADER>x       :set paste<BAR>:norm! "*p<BAR>:set nopaste<CR>
"" bad because leader is blocked in insert
"noremap! <silent> <LEADER>c  <C-O>:set paste<BAR>:norm! "+p<BAR>:set nopaste<CR>
"noremap! <silent> <LEADER>p  <C-O>:set pastetoggle<CR>
"noremap! <silent> <LEADER>x  <C-O>:set paste<BAR>:norm! "*p<BAR>:set nopaste<CR>


nnoremap <silent> ,,v :<C-u>call Voom_ToTreeOrBodyWin()<CR>

"adjust line len for paragraph
noremap <silent> gqp :call Preserve("norm! {gq}")<CR>

" kill plenking in quotes:
noremap ,pl :g/^>/s/  *\([!?,.]\)/\1/g<CR>

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Spell Checking
nnoremap p[ [s z=
nnoremap p] ]s z=

" ---- some fixes
noremap! <Esc>[H  <Home>
noremap! <Esc>[F  <End>

noremap <ESC>[H  0
noremap <ESC>[F  $

" ---- DE-LAYOUT
" enter item
noremap ä <C-]>
" jump back
noremap ö <C-O>
noremap ü z=

" -----------------------------------------------------------
" MOUSE

" turn off the mouse in the xterm (to enable, set mouse=a)
" set mouse=

" mouse in insert/visual/help mode only
set mouse=vih

set nomousehide

"set mousefocus
"set mousemodel=extend

" commands
command Ma :set mouse=a
command Mc :set mouse=c

" keybindings
noremap ,ma :set mouse=a<CR>
noremap ,mc :set mouse=c<CR>




" -----------------------------------------------------------
" PRINTER

  set printoptions=syntax:n,number:y,paper:A4

" Set paper size from /etc/papersize if available (Debian-specific)
try
  if filereadable('/etc/papersize')
    let s:papersize = matchstr(system('/bin/cat /etc/papersize'), '\p*')
    if strlen(s:papersize)
      let &printoptions = "paper:" . s:papersize
    endif
    unlet! s:papersize
  endif
catch /E145/
endtry

" -----------------------------------------------------------
" Crazy Stuff

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
" --------
" We know xterm-debian is a color terminal
if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif
" --------

"bites with YouCompleteMe ????? TODO
if has('wildmenu')
    " use wildmenu for command-completition
    set wildmenu
    set wildmode=longest,full
endif

"bites with YouCompleteMe ????? TODO
set completeopt=menuone,menu,longest ",preview


" -----------------------------------------------------------
" PLUGINS

let g:ConqueGdb_Leader = '<Leader>g'

" calendar.vim
let g:calendar_diary= '~/.vim_diary'

"" man plugin
runtime ftplugin/man.vim

for file in [ 'obi.vim', 'obi-keys.vim'
          \ , 'airline.vim', 'clang.vim', 'rust.vim'
          \ , 'snipmate.vim', 'ctrlp-search.vim'
          \ , 'dispatch.vim', 'youcompleteme.vim'
          \ ]
    let s:obi_next_plugin = expand("~/.vim/startup/" . file)
    if filereadable(s:obi_next_plugin)
        exec 'source ' .  s:obi_next_plugin
    endif
endfor


" -----------------------------------------------------------
" UNSORTED STUFF -- DISABLED

""stuff von david
"let c_space_errors=1
"let c_gnu=1
"let c_no_curly_error=1
"
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" set background=dark

""" old obi shortcuts
" Ctags
"  let Tlist_Ctags_Cmd='/usr/bin/ctags'
"  nnoremap <silent> <F8> :Tlist<CR>
"  nnoremap <silent> <F7> :TlistSync<CR>
" Alternate
"  nnoremap <silent> <F9> :A<CR>
"  nnoremap <silent> <F10> :w \| :A<CR>
"
"  some tests
"  if has("gui_running") -- check for gvim
"  if exists('$DISPLAY') --
"  if has("x11")         -- check if it is compiled with x11
"

"if you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

"http://vim.wikia.com/wiki/VimTip1386
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

