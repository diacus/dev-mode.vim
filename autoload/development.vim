" ===========================================================================
" FILE        : autoload/development.vim
" DESCRIPTION : Helper functions for plugin/development.vim
" AUTHOR      : @diacus (diacus.magnuz@gmail.com)
" LAST CHANGE : Thu Jul 27 10:34:06 PM CST 2023
" CREATION    : Thu Jun  7 11:15:14 CDT 2018
" ===========================================================================

let g:code_filetypes = [
      \'c',
      \'cpp',
      \'css',
      \'go',
      \'haskell',
      \'html',
      \'java',
      \'javascript',
      \'javascriptreact',
      \'json',
      \'lua',
      \'matlab',
      \'perl',
      \'php',
      \'python',
      \'rust',
      \'scala',
      \'sh',
      \'sql',
      \'typescript',
      \'vim',
      \'xml',
      \'yaml',
      \'zsh',
      \]

function! development#setup()
  if exists('b:did_development_setup') || index(g:code_filetypes, &ft) == -1
    return
  endif
  set cursorline

  let code_indent = exists('b:code_indent')? b:code_indent : 2

  " Format
  for option in ['tabstop', 'shiftwidth', 'softtabstop']
    execute 'setlocal ' . option . '=' . code_indent
  endfor

  call development#margin_on()

  setlocal formatoptions=croqj
  setlocal expandtab " No tabs in your source code :)

  setlocal numberwidth=6

  let b:did_development_setup = 1
endfunction

function! development#toogle_number()
  " Show line numbers
  if v:version >= 703
    let &relativenumber = &number
    set relativenumber!
  endif
  set number!
endfunction

function! development#cursor_line_toggle()
  if &cursorcolumn
    set nocursorcolumn
    set cursorline
  else
    set cursorline!
  endif
endfunction

function! development#cursor_cross_toggle()
  if &cursorcolumn != &cursorline
    set cursorcolumn
    set cursorline
  else
    set cursorcolumn!
    set cursorline!
  endif
endfunction

function! development#date()
  normal 0f:ld$
  read !date
  normal kJ$
endfunction

function! development#update_tags()
  if filereadable('tags')
    execute 'silent !ctags -R --exclude=env --exclude=.venv --exclude=node_modules . &'
    redraw!
  endif
endfunction

function! development#make_tags()
  if exists('b:did_development_setup')
    execute 'silent !ctags -R --exclude=env --exclude=.venv --exclude=node_modules . &'
    redraw!
  endif
endfunction

function! development#margin_on()
  let txt_width = &textwidth > 0 ? &textwidth + 1 : 80
  execute 'match ErrorMsg /\%>'. txt_width . 'v.\+/'
  let b:margin = 1
endfunction

function! development#margin_off()
  let txt_width = &textwidth > 0 ? &textwidth + 1 : 80
  execute 'match Normal /\%>'. txt_width . 'v.\+/'
  if exists('b:margin')
    unlet b:margin
  endif
endfunction

function! development#margin_toggle()
  if exists('b:margin')
    call development#margin_off()
  else
    call development#margin_on()
  endif
endfunction
