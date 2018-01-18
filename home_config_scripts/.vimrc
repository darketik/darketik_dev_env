"-----------------
" Option general -
"-----------------
set nocompatible              " be iMproved, required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

call vundle#end()            " required
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

set ttytype=xterm

set shell=/bin/bash                                    " we set the shell to use for launching the interractive command
set showmode                                           " Pour afficher le mode courant
set showcmd                                            " Pour afficher la commande courante
set vb t_vb=                                                                    " Pour ne pas avoir de bip a la con ni de visualbell
set history=1000                                       " Pour avoir une taille d'historique consequente
set confirm                                                                     " Affiche une boite de dialogue de confirmation avant de faire des operations limite.
set incsearch                                          " Pour afficher directement le paterns le plus proche recherche
set hlsearch                                           " Pour que tous les paterns trouver soient soulignes
set wildmode=longest,list                                                       " Pour que la completion de la command line soit idem que tcsh
set wildmenu                                           " Pour avoir un jolie menu dans lequel on peut se deplacer lors de l'auto-completion
set keywordprg=                                                                 " Pour afficher l'aide plustot que les pages de manuels

set encoding=utf-8
set fileencoding=utf-8

let mapleader='\'                                                               " Touche leader en insertion

set hid                                "Hide abandon buffers in order to not lose undo history.
set dictionary+=/usr/share/dict/words
set mouse=a                                            " ables use of the mouse in terminal vim
"set ttymouse=xterm2_v2.1

"-------------------------
" Option de mise en page -
"-------------------------
set guifont=-misc-fixed-medium-r-normal--13-120-75-75-c-80-iso8859-8            " Font utilise
"+ set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
set guioptions=aAciF                                                            " Options de presentation du gvim
set mousehide                                                                   " Pour que la souris soit cacher lorsque je tapes du texte
set sidescroll=1                                                                " Pour definir la taille de scrolling de gvim
set listchars+=precedes:<,extends:>                                             " Pour afficher de jolie caractere lorsque la texte depasse horizontalement
set wrap                                               " Pour que les lignes ne soit pas automatiquement redirige ver le debut
set ch=1                                               " Pour definir la taille de la ligne de commande
set ruler                                              " Pour avoir le numero de ligne a gauche
set rulerformat=%40(%l,%c%V\ %P%=%y%h%m%r\ \ %<%{strftime('%a\ %d\ %b\ %H:%M')}%)
set statusline=%f\ \ %l,%c%V\ %P%=%y%h%m%r\ \ %<%{strftime('%a\ %d\ %b\ %H:%M')}
set backspace=indent,eol,start                                                  " Pour indiquer  que l'on peut supprimer les espaces a une nouvelle ligne en mode insertion
colorscheme delek                                      " Change colorscheme from default to delek

" Pour activer la syntax highlightning uniquement lorsque l'on dispose de terminal couleur
" if &t_Co > 2
set highlight=8:SpecialKey,@n,d:Directory,e:ErrorMsg,i:IncSearch,lb,m:MoreMsg,M:ModeMsg,nn,r:Question,s:StatusLine,S:StatusLineNC,c:VertSplit,t:Title,vr,Vr,w:WarningMsg,W:WildMenu,f:Folded,F:FoldColumn,A:DiffAdd,C:DiffChange,D:DiffDelete,T:DiffText
" else
"     set highlight=8n,@n,db,er,ir,lb,mn,Mb,rb,nn,srb,Sr,tn,cr,vr,Vr,wb,Wn,fn,Fn
" endif

"-------------------------------
" Option de syntax automatique -
"-------------------------------
syntax on                                              " Pour activer le highlightnig du fichier
set bg=dark
set autoindent
set nonumber                                           " Affiche les numeros de lignes sur la gauches
set shiftwidth=2
set tabstop=2                                          " Definit la taille de l'indentation automatique
"+ set ts=3
"+ set et                                                 " Petmet d'avoir des espaces a la place des tabulations
set noet                                               " Permet de ne pas avoir des espaces a la place des tabulations
set showmatch                                          " Pour afficher la parenthese ouvrante correspondant a la parenthese fermante que l'on vient d'ecrire. 
set matchpairs+=<:>                                    " Pour definir les caracteres de parenthesages
set matchtime=5                                        " Pour definir le temps de visualisation de la parenthese ouvrante correspondant a la parenthese fermante que l'on vient d'ecrire. e
set hlsearch                                           " Pour que recherhche automatiquement le highlightnig du fichier
set noignorecase                                       " Case sensitive search
set lbr                                                " Wrap text instead of being on one line
filetype plugin on                                     " Indent automatically depending on filetype
filetype indent on
filetype on

augroup textformat
autocmd BufNewFile,BufReadPre *.pal
            \ setlocal formatoptions=cqn
autocmd BufNewFile,BufReadPre *.txt,*.tex
            \ setlocal formatoptions=tcoqanwr1
autocmd BufNewFile,BufReadPre *.py,*.c,*.cc,*.cpp,*.CC,*.h,*rc,*.sh
            \ setlocal formatoptions=cqnawro
augroup END
" filetype detection
autocmd BufRead,BufNewFile *.txt		setfiletype text

set textwidth=78                                       " Taille maximal des lignes
set formatoptions=cqn                                  " Formatage automatique du texte

"-----------------------
" Special key bindings -
"-----------------------

" For moving around split windows
nmap <s-down>   <c-w>j
nmap <s-up>     <c-w>k
nmap <s-left>   <c-w>h
nmap <s-right>  <c-w>l

"pour naviguer d'un buffer a l'autre
"+ nmap <M-PageUp> :w<CR>:bp<CR>
"+ nmap <M-PageDown> :w<CR>:bn<CR>
"+ nmap <C-PageUp> :bp!<CR>
"+ nmap <C-PageDown> :bn!<CR>
"pour naviguer dun buffer a l'autre
map <M-Left> 	:bprevious<CR>
map <M-Right> 	:bnext<CR>
map <M-Up>		:bfirst<CR>
map <M-Down>	:blast<CR>

"moving from a tab to another
"+ map <C-T>    :tabnew<CR>
map <C-N>    gt
map <C-P>    gT

" pour vimdiff
"+ nmap <A-Left> :diffget<CR>
"+ nmap <A-Right> :diffput<CR>

" Note that <M-a> is different from <M-A>, but <C-a> and <C-A> is the same.
map <C-M>m	:make<CR>
map <C-M>M	:make -j<CR>

" Next error
map <C-M>n    :cn<CR>
" Prev error
map <C-M>p   :cp<CR>
" Errors list
map <C-M>c	:cclose<CR>
map <C-M>o	:copen<CR>
" Pour effectuer les jump de tag
"+ map <C-o>    :tnext<CR>
"+ map <C-p>    :tprevious<CR>
"
" File saving
map <C-S> :w<CR>
imap <C-S> <C-O>:w<CR>
" <C-M>t is trapped by NX...
"map <C-M>t 	:!ctags -R --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q -f "./.tags" `pwd`<CR>
map <Leader>ct 	:!ctags -R --c-kinds=+cdefglmnpstuvx --c++-kinds=+p --fields=+iaSm --extra=+q -f "./.tags" `pwd`<CR>

set tags=.tags,tags,~/.vim/tags

set nocp

"-----------------------
" OmniCppComplete
"-----------------------
let OmniCpp_NamespaceSearch = 2
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
set omnifunc=syntaxcomplete#Complete " override built-in C omnicomplete with C++ OmniCppComplete plugin
let OmniCpp_GlobalScopeSearch   = 1
let OmniCpp_DisplayMode         = 1
let OmniCpp_ShowScopeInAbbr     = 0 "do not show namespace in pop-up
let OmniCpp_ShowPrototypeInAbbr = 1 "show prototype in pop-up
let OmniCpp_ShowAccess          = 1 "show access in pop-up
let OmniCpp_SelectFirstItem     = 2 "select first item in pop-up

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,menuone,longest,preview

"----------------------------------------------
" Option spécifique a certain type de fichier -
"----------------------------------------------

if expand("%:e")==".c" || expand("%:e")==".cpp" || expand("%:e")==".h"
   set nowrap                                           " Pour que les lignes soit automatiquement redirige ver le debut
endif

"-----------------------------
" Option pour les commentaires
"-----------------------------
let g:EnhCommentifyAltOpen='|+'
let g:EnhCommentifyAltClose='+|'
let g:EnhCommentifyIdentString='+'
let g:EnhCommentifyIgnoreWS='Yes'
let g:EnhCommentifyUseAltKeys='No'
let g:EnhCommentifyTraditionalMode='No'
let g:EnhCommentifyFirstLineMode='No'
let g:EnhCommentifyUserMode='Yes'
let g:EnhCommentifyAlignRight='Yes'
let g:EnhCommentifyUseSyntax='Yes'
let g:EnhCommentifyMultiPartBlocks='No'
let g:EnhCommentifyPretty='Yes'
let g:EnhCommentifyUserBindings='No'
let g:EnhCommentifyRespectIndent='Yes'
let g:EnhCommentifyUseBlockIndent='yes'

nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <Esc>:Hexmode<CR>
vnoremap <C-H> :<C-U>Hexmode<CR>

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

" :ab 
:ab be beginendO
:ab Re Ready
:ab fo forkjoinO
:ab di $display("%");F%s:call getchar()
:ab .B .BeginRead(%);F%s:call getchar()
:ab .W .Write(%);F%s:call getchar()
:ab .E .EndRead();
:imap  yyp:s/BeginRead(.*);/EndRead();/ O
:ab al alwaysbegin endk$i
:ab push push_channel_% F%s:call getchar()
:ab pull pull_channel_% F%s:call getchar()
:ab mod module  ();endmodule2kO
" :ab ca case (%)endcase3k^[F%s:call getchar()

:map  :'<,'>s/.*\.\(in\\|out\) /\t\./ :'<,'>s/,/(),/ :'<,'>s/module\s\(.*\)\s/\1 U_\1 (/g

function! GnuIndent()
  setlocal formatoptions=croql cindent
  setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
  setlocal shiftwidth=2
  setlocal tabstop=8
  setlocal noet
endfunction
au FileType c,cpp call GnuIndent()


function! SVIndent()
  setlocal formatoptions=croql cindent
  setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
  setlocal shiftwidth=3
  setlocal tabstop=3
  setlocal et
endfunction
au FileType verilog,systemverilog call SVIndent()

" Add Guard header for C/C++ files
function AddIfndefGuard()
  let s:uppercase_filename = toupper(expand("%:t:r"))
  let s:uppercase_filename = substitute(s:uppercase_filename,"-","_","g")
  if strlen(s:uppercase_filename) != 0
    let s:header_guard = "__" . s:uppercase_filename . "_H__"
    echo s:header_guard
    call append(0, "#ifndef " . s:header_guard)
    call append(1, "#define " . s:header_guard)
    let s:last_line = line('$')
    call append(s:last_line, "#endif /* " . s:header_guard . " */")
 endif
endfunction

nmap <Leader>h :call AddIfndefGuard()<CR>

