"set line number
:set number

"set relative number
:set relativenumber

"set indentation
:set autoindent

"set tab space
:set tabstop=4

"set ruler
:set ruler

"set status bar
:set laststatus=2

"set compatibility to vim only not vi
:set nocompatible

"automatically wrap text that extends beyond the screen legnth
:set wrap

"set encoding
:set encoding=utf-8

"enable syntax and plugins (for netrw)
syntax enable
filetype plugin on

"FINDING FILES:
"
"search down into subfolders
"provides tab-completion for all file-related tasks
set path+=**

"display all matching files when we tab comlete
set wildmenu

"Enable Omnicomlete feature
set omnifunc=syntaxcomplete#Complete

"set showmode
set showmode

"NOW WE CAN:
"- Hit tab to :find by partial match
"- Use * to make it fuzzy
"
"THINGS TO CONSIDER:
" :b lets you autocomplete any open buffer

"TAG JUMPING
"
"create the 'tags' file (may need to install ctags first)
command! MakeTags !ctags -R .

"NOW WE CAN:
" - use ctrl+] to jump to tag under cursor
" - use g+ctrl+] for ambiguous tags
" - use ctrl+t to jump back to the tag stack
"
"THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags
