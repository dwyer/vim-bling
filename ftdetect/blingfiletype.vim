" We take care to preserve the user's fileencodings and fileformats,
" because those settings are global (not buffer local), yet we want
" to override them for loading Bling files, which are defined to be UTF-8.
let s:current_fileformats = ''
let s:current_fileencodings = ''

" define fileencodings to open as utf-8 encoding even if it's ascii.
function! s:blingfiletype_pre() abort
  let s:current_fileformats = &g:fileformats
  let s:current_fileencodings = &g:fileencodings
  set fileencodings=utf-8 fileformats=unix
  setlocal filetype=bling
endfunction

" restore fileencodings as others
function! s:blingfiletype_post() abort
  let &g:fileformats = s:current_fileformats
  let &g:fileencodings = s:current_fileencodings
endfunction

au BufNewFile *.bling setlocal filetype=bling fileencoding=utf-8 fileformat=unix
au BufRead *.bling call s:blingfiletype_pre()
au BufReadPost *.bling call s:blingfiletype_post()

" vim: sw=2 sts=2 et
