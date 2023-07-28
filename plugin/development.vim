" ===========================================================================
" FILE        : plugin/development.vim
" DESCRIPTION : Common Vim configuration for source code files.
" AUTHOR      : @diacus (diacus.magnuz@gmail.com)
" LAST CHANGE : Thu Jul 27 10:36:48 PM CST 2023
" CREATION    : Wed Apr 20 01:08:50 CDT 2016
" ===========================================================================
autocmd! BufNewFile,BufRead *.ts set filetype=typescript
autocmd! FileType,BufNewFile,BufRead * call development#setup()
autocmd! BufWrite * call development#update_tags()

command! -nargs=0 InsertDate call development#date()
command! -nargs=0 CreateTags call development#make_tags()

nnoremap <leader>tx :call development#toogle_cursor_cross()<CR>
nnoremap <leader>tn :call development#toogle_number()<CR>
nnoremap <leader>tm :call development#margin_toggle()<CR>
