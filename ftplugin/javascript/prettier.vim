" File: prettier.vim
" Author: Shinya Ohyanagi <sohyanagi@gmail.com>
" WebPage:  http://github.com/heavenshell/vim-prettier/
" Description: Prettier for Vim
" License: BSD, see LICENSE for more details.
"
" Error handling was copied from Golang's vim plugin.
" see https://github.com/vim-jp/vim-go-extra/blob/master/ftplugin/go/fmt.vim
"
" Async format was inspiered from haya14busa's vim-gofmt.
" see https://github.com/haya14busa/vim-gofmt
"
" Copyright 2011 The Go Authors. All rights reserved.
" Copyright 2017 haya14busa. All rights reserved.
" Copyright 2017 Shinya Ohyanagi. All rights reserved.

let s:save_cpo = &cpo
set cpo&vim

" version check
if !has('channel') || !has('job')
  echoerr '+channel and +job are required for prettier.vim'
  finish
endif

command! -buffer Prettier :call prettier#run()

noremap <silent> <buffer> <Plug>(Prettier)  :Prettier <CR>

let &cpo = s:save_cpo
unlet s:save_cpo
