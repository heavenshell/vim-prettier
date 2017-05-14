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

let s:root_path = ''
let s:formatted = []

function! prettier#detect_root()
  if s:root_path != ''
    return s:root_path
  endif

  let path = expand('%:p')
  let root_path = finddir('node_modules', path . ';')
  let s:root_path = root_path

  return root_path
endfunction

function! prettier#bin()
  let bin = ''
  if executable('prettier-eslint') == 0
    let root_path = prettier#detect_root()
    let bin = root_path . '/.bin/prettier-eslint'
  else
    let bin = exepath('prettier-eslint')
  endif

  return bin
endfunction

function! s:callback(ch, msg)
  " This function is almost copied from Golang's vim plugin.
  " Copyright 2011 The Go Authors. All rights reserved.
  " see also
  "   https://github.com/vim-jp/vim-go-extra/blob/master/ftplugin/go/fmt.vim
  if v:shell_error
    let errors = []
    for line in getline(1, line('$'))
      let tokens = matchlist(line, '^\(.\{-}\):\(\d\+\):\(\d\+\)\s*\(.*\)')
      if !empty(tokens)
        call add(errors, {"filename": @%,
                          \"lnum":     tokens[2],
                          \"col":      tokens[3],
                          \"text":     tokens[4]})
      endif
    endfor
    if empty(errors)
      % | " Couldn't detect prettier error format, output errors
    endif
    undo
    if !empty(errors)
      call setqflist(errors, 'r')
    endif
    echohl Error | echomsg "Prettier returned error" | echohl None
    return
  endif

  call add(s:formatted, a:msg)
endfunction

function! s:error_callback(ch, msg)
  echomsg printf('fmt err: %s', a:msg)
endfunction

function! s:exit_callback(ch, msg, current_bufnr, changedtick, force_write)
  " This function is inspiered from haya14busa's gofmt.vim.
  " Copyright 2017 haya14busa. All rights reserved.
  " see also
  "   https://github.com/haya14busa/vim-gofmt/blob/master/autoload/gofmt.vim
  if b:changedtick != a:changedtick
    echohl Error | echomsg 'Format is Canceled. Buffer was edited.' | echohl None
    return
  endif
  if a:current_bufnr != bufnr('%')
    echomsg 'Formatted buffer is changed.'
    return
  endif

  let view = winsaveview()
  if a:force_write == 'file'
    e!
    call winrestview(view)
    return
  endif

  if len(s:formatted) == 0
    return
  endif

  silent execute '% delete'

  " Preitter v1.0 add extra blank line.
  if s:formatted[len(s:formatted) - 1] == ''
    call setline(1, s:formatted[0:len(s:formatted) - 2])
  else
    call setline(1, s:formatted)
  endif
  call winrestview(view)
endfunction

function! prettier#run(...)
  if exists('s:job') && job_status(s:job) != 'stop'
    call job_stop(s:job)
  endif
  let s:formatted = []
  let bin = prettier#bin()
  let current_bufnr = bufnr('%')
  let changedtick = b:changedtick

  let file = expand('%:p')
  let mode = a:0 > 0 ? 'file' : 'buffer'
  let cmd = bin . ' --stdin'
  if mode == 'file'
    let cmd = bin . ' --write ' . file
  endif
  let s:job = job_start(cmd, {
        \ 'callback': {c, m -> s:callback(c, m)},
        \ 'exit_cb': {c, m -> s:exit_callback(c, m, current_bufnr, changedtick, mode)},
        \ 'err_cb': {c, m -> s:error_callback(c, m)},
        \ 'in_io': mode,
        \ 'in_name': file,
        \ })
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
