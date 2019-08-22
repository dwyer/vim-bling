" Vim syntax file
" Language:	Blingdoc (generated documentation for bling)
" Maintainer:	David Barnett (https://github.com/google/vim-ft-go)
" Last Change:	2014 Aug 16

if exists('b:current_syntax')
  finish
endif

syn case match
syn match blingdocTitle "^\([A-Z][A-Z ]*\)$"

command -nargs=+ HiLink hi def link <args>

HiLink blingdocTitle Title

delcommand HiLink

let b:current_syntax = 'blingdoc'

" vim: sw=2 sts=2 et
