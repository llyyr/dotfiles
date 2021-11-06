set nocompatible

""" Init plugins with dein
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  "call dein#add('Shougo/deoplete.nvim')
  "call dein#add('deoplete-plugins/deoplete-jedi')
  "call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/Defx.nvim')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('poiuto/gruvbox9')
  call dein#add('Yggdroot/indentLine')
  call dein#add('mbbill/undotree')
  call dein#add('cohama/lexima.vim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#end()
  call dein#save_state()
endif
"""

function! g:Sline()
  let l:mode_map = {
    \ 'n': 'NORMAL', 'i': 'INSERT', 'R': 'REPLACE',
    \ 'v': 'VISUAL', 'V': 'V-LINE', "\<C-v>": 'V-BLOCK',
    \ 'c': 'COMMAND', 's': 'SELECT', 'S': 'S-LINE',
    \ "\<C-s>": 'S-BLOCK', 't': 'TERMINAL',
    \   }
  return get(l:mode_map, mode())
endfunction
set statusline=%1*\ %{Sline()}\ %2*\ %f\ %m\ %r%=\ %{&ff}\ \|\ %{strlen(&fenc)?&fenc:'none'}\ \|\ %{&filetype}\ \|\ %3*\ %l:%L\ 
fun! HumanSize(bytes) abort
    let l:bytes = a:bytes
    let l:sizes = ['B', 'KiB', 'MiB', 'GiB']
    let l:i = 0
    while l:bytes >= 1024
        let l:bytes = l:bytes / 1024.0
        let l:i += 1
    endwhile
    return printf('%.1f%s', l:bytes, l:sizes[l:i])
endfun

let &statusline .= "| %{HumanSize(line2byte('$') + len(getline('$')))}"

set laststatus=2
set noshowmode
""" Misc
" Set mapleader
let mapleader = ","

" Use +/* clipboard registers
set clipboard=unnamed,unnamedplus

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Configure backspace so it acts as it should act
set backspace=indent,eol,start
set whichwrap+=<,>,h,l


" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin indent on

" Enable mouse support
set mouse=a

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap linebreak nolist "Wrap lines

" Always show current position
set ruler

" Always show line number
set nu rnu
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
"""



""" Moving around in tabs/windows/buffers
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <M-l> :bnext<cr>
map <M-h> :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"""



""" Editing mappings
" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Spellchecker shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m :setlocal ff=unix<cr>:w<cr>:e<cr>

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
"""



""" Visual mode stuff

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
"""



""" Colors
" Enable syntax highlighting
syntax enable

" Display true colors in the terminal
set t_8f=\[[38;2;%lu;%lu;%lum
set t_8b=\[[48;2;%lu;%lu;%lum
set termguicolors

" Set background
set background=dark

" gruvbox settings, these need to be set before colorscheme
" gruvbox syntax colors based on filetype
let g:gruvbox_filetype_hi_groups = 1

" gruvbox highlighting based on plugin
let g:gruvbox_plugin_hi_groups = 1

" gruvbox transparent background
let g:gruvbox_transp_bg = 1

" Set colorscheme (gruvbox9, gruvbox9_hard, gruvbox9_soft available)
colorscheme gruvbox9_hard

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
	set t_Co=256
    set guitablabel=%M\ %t
endif

"""



""" Turn persistent undo on, so that you can undo even when you close a buffer/VIM
"try
"    set undodir=~/.vim_runtime/temp_dirs/undodir
"    set undofile
"catch
"endtry
"""



""" Plugins
" Disable deoplete on startup
"let g:deoplete#enable_at_startup = 0

" Enable it when entering insert mode
"autocmd InsertEnter * call deoplete#enable()

""" Defx
nnoremap <silent> <leader>e :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>


call defx#custom#option('_', {
	\ 'winwidth': 25,
	\ 'split': 'vertical',
	\ 'direction': 'topleft',
	\ 'show_ignored_files': 0,
	\ 'columns': 'indent:git:icons:filename',
	\ 'root_marker': ' ',
	\ 'ignored_files':
	\     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
	\   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc'
	\ })
	"\ 'listed': 1,

call defx#custom#column('git', {
	\   'indicators': {
	\     'Modified'  : '•',
	\     'Staged'    : '✚',
	\     'Untracked' : 'ᵁ',
	\     'Renamed'   : '≫',
	\     'Unmerged'  : '≠',
	\     'Ignored'   : 'ⁱ',
	\     'Deleted'   : '✖',
	\     'Unknown'   : '⁇'
	\   }
	\ })

call defx#custom#column('mark', { 'readonly_icon': '', 'selected_icon': '' })

" defx-icons plugin
let g:defx_icons_column_length = 2
let g:defx_icons_mark_icon = ''

" Internal use
let s:original_width = get(get(defx#custom#_get().option, '_'), 'winwidth')

" Events
augroup user_plugin_defx
	autocmd!

	" Delete defx if it's the only buffer left in the window
	autocmd WinEnter * if &filetype == 'defx' && winnr('$') == 1 | bdel | endif

	" Move focus to the next window if current buffer is defx
	autocmd TabLeave * if &filetype == 'defx' | wincmd w | endif

	" Clean Defx window once a tab-page is closed
	" autocmd TabClosed * call <SID>defx_close_tab(expand('<afile>'))

	" Automatically refresh opened Defx windows when changing working-directory
	" autocmd DirChanged * call <SID>defx_handle_dirchanged(v:event)

	" Define defx window mappings
	autocmd FileType defx call <SID>defx_mappings()

augroup END

" Internal functions
function! s:defx_toggle_tree() abort
	" Open current file, or toggle directory expand/collapse
	if defx#is_directory()
		return defx#do_action('open_or_close_tree')
	endif
	return defx#do_action('multi', ['drop', 'quit'])
endfunction

function! s:defx_handle_dirchanged(event)
	" Refresh opened Defx windows when changing working-directory
	let l:cwd = get(a:event, 'cwd', '')
	let l:scope = get(a:event, 'scope', '')   " global, tab, window
	let l:current_win = winnr()
	if &filetype ==# 'defx' || empty(l:cwd) || empty(l:scope)
		return
	endif

	" Find tab-page's defx window
	for l:nr in tabpagebuflist()
		if getbufvar(l:nr, '&filetype') ==# 'defx'
			let l:winnr = bufwinnr(l:nr)
			if l:winnr != -1
				" Change defx's window directory location
				if l:scope ==# 'window'
					execute 'noautocmd' l:winnr . 'windo' 'lcd' l:cwd
				else
					execute 'noautocmd' l:winnr . 'wincmd' 'w'
				endif
				call defx#call_action('cd', [ l:cwd ])
				execute 'noautocmd' l:current_win . 'wincmd' 'w'
				break
			endif
		endif
	endfor
endfunction

function! s:jump_dirty(dir) abort
	" Jump to the next position with defx-git dirty symbols
	let l:icons = get(g:, 'defx_git_indicators', {})
	let l:icons_pattern = join(values(l:icons), '\|')

	if ! empty(l:icons_pattern)
		let l:direction = a:dir > 0 ? 'w' : 'bw'
		return search(printf('\(%s\)', l:icons_pattern), l:direction)
	endif
endfunction

function! s:defx_mappings() abort
	" Defx window keyboard mappings
	setlocal signcolumn=no expandtab

	nnoremap <silent><buffer><expr> <CR>  <SID>defx_toggle_tree()
	nnoremap <silent><buffer><expr> e     <SID>defx_toggle_tree()
	nnoremap <silent><buffer><expr> l     <SID>defx_toggle_tree()
	nnoremap <silent><buffer><expr> h     defx#do_action('close_tree')
	nnoremap <silent><buffer><expr> t     defx#do_action('open_tree_recursive')
	nnoremap <silent><buffer><expr> st    defx#do_action('multi', [['drop', 'tabnew'], 'quit'])
	nnoremap <silent><buffer><expr> sg    defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
	nnoremap <silent><buffer><expr> sv    defx#do_action('multi', [['drop', 'split'], 'quit'])
	nnoremap <silent><buffer><expr> P     defx#do_action('open', 'pedit')
	nnoremap <silent><buffer><expr> y     defx#do_action('yank_path')
	nnoremap <silent><buffer><expr> x     defx#do_action('execute_system')
	nnoremap <silent><buffer><expr> gx    defx#do_action('execute_system')
	nnoremap <silent><buffer><expr> .     defx#do_action('toggle_ignored_files')

	" Defx's buffer management
	nnoremap <silent><buffer><expr> q      defx#do_action('quit')
	nnoremap <silent><buffer><expr> se     defx#do_action('save_session')
	nnoremap <silent><buffer><expr> <C-r>  defx#do_action('redraw')
	nnoremap <silent><buffer><expr> <C-g>  defx#do_action('print')

	" File/dir management
	nnoremap <silent><buffer><expr><nowait> c  defx#do_action('copy')
	nnoremap <silent><buffer><expr><nowait> m  defx#do_action('move')
	nnoremap <silent><buffer><expr><nowait> p  defx#do_action('paste')
	nnoremap <silent><buffer><expr><nowait> r  defx#do_action('rename')
	nnoremap <silent><buffer><expr><nowait> d  defx#do_action('remove_trash')
	nnoremap <silent><buffer><expr> K  defx#do_action('new_directory')
	nnoremap <silent><buffer><expr> N  defx#do_action('new_multiple_files')

	" Jump
	nnoremap <silent><buffer>  [g :<C-u>call <SID>jump_dirty(-1)<CR>
	nnoremap <silent><buffer>  ]g :<C-u>call <SID>jump_dirty(1)<CR>

	" Change directory
	nnoremap <silent><buffer><expr><nowait> \  defx#do_action('cd', getcwd())
	nnoremap <silent><buffer><expr><nowait> &  defx#do_action('cd', getcwd())
	nnoremap <silent><buffer><expr> <BS>  defx#async_action('cd', ['..'])
	nnoremap <silent><buffer><expr> ~     defx#async_action('cd')
	nnoremap <silent><buffer><expr> u   defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> 2u  defx#do_action('cd', ['../..'])
	nnoremap <silent><buffer><expr> 3u  defx#do_action('cd', ['../../..'])
	nnoremap <silent><buffer><expr> 4u  defx#do_action('cd', ['../../../..'])

	" Selection
	nnoremap <silent><buffer><expr> *  defx#do_action('toggle_select_all')
	nnoremap <silent><buffer><expr><nowait> <Space> defx#do_action('toggle_select') . 'j'

	nnoremap <silent><buffer><expr> S  defx#do_action('toggle_sort', 'Time')
	nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns', 'indent:mark:filename:type:size:time')

	" Tools
	nnoremap <silent><buffer><expr> w   defx#do_action('call', '<SID>toggle_width')
	nnoremap <silent><buffer><expr> gd  defx#async_action('multi', ['drop', ['call', '<SID>git_diff']])
	nnoremap <silent><buffer><expr> gr  defx#do_action('call', '<SID>grep')
	nnoremap <silent><buffer><expr> gf  defx#do_action('call', '<SID>find_files')
	if exists('$TMUX')
		nnoremap <silent><buffer><expr> gl  defx#async_action('call', '<SID>explorer')
	endif
endfunction

" TOOLS
function! s:git_diff(context) abort
	execute 'GdiffThis'
endfunction

function! s:find_files(context) abort
	" Find files in parent directory with Denite
	let l:target = a:context['targets'][0]
	let l:parent = fnamemodify(l:target, ':h')
	silent execute 'wincmd w'
	silent execute 'Denite file/rec:'.l:parent
endfunction

function! s:grep(context) abort
	" Grep in parent directory with Denite
	let l:target = a:context['targets'][0]
	let l:parent = fnamemodify(l:target, ':h')
	silent execute 'wincmd w'
	silent execute 'Denite grep:'.l:parent
endfunction

function! s:toggle_width(context) abort
	" Toggle between defx window width and longest line
	let l:max = 0
	for l:line in range(1, line('$'))
		let l:len = len(getline(l:line))
		let l:max = max([l:len, l:max])
	endfor
	let l:new = l:max == winwidth(0) ? s:original_width : l:max
	call defx#call_action('resize', l:new)
endfunction

function! s:explorer(context) abort
	" Open file-explorer split with tmux
	let l:explorer = s:find_file_explorer()
	if empty('$TMUX') || empty(l:explorer)
		return
	endif
	let l:target = a:context['targets'][0]
	let l:parent = fnamemodify(l:target, ':h')
	let l:cmd = 'split-window -p 30 -c ' . l:parent . ' ' . l:explorer
	silent execute '!tmux ' . l:cmd
endfunction

function! s:find_file_explorer() abort
	" Detect terminal file-explorer
	let s:file_explorer = get(g:, 'terminal_file_explorer', '')
	if empty(s:file_explorer)
		for l:explorer in ['lf', 'hunter', 'ranger', 'vifm']
			if executable(l:explorer)
				let s:file_explorer = l:explorer
				break
			endif
		endfor
	endif
	return s:file_explorer
endfunction


""" Undotree
noremap <Leader>u :UndotreeToggle<CR>
set undodir=~/.cache/undo
set undofile
au BufNewFile,BufRead /tmp/* setl noundofile
let g:undotree_WindowLayout=2
let g:undotree_SetFocusWhenToggle=1
"""
