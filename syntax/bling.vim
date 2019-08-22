" Vim syntax file
" Language:	Bling
" Maintainer:	David Barnett (https://github.com/blingogle/vim-ft-bling)
" Last Change:	2014 Aug 16

" Options:
"   There are some options for customizing the highlighting; the recommended
"   settings are the default values, but you can write:
"     let OPTION_NAME = 0
"   in your ~/.vimrc file to disable particular options. You can also write:
"     let OPTION_NAME = 1
"   to enable particular options. At present, all options default to off.
"
"   - g:bling_highlight_array_whitespace_error
"     Highlights white space after "[]".
"   - g:bling_highlight_chan_whitespace_error
"     Highlights white space around the communications operator that don't
"     follow the standard style.
"   - g:bling_highlight_extra_types
"     Highlights commonly used library types (io.Reader, etc.).
"   - g:bling_highlight_space_tab_error
"     Highlights instances of tabs following spaces.
"   - g:bling_highlight_trailing_whitespace_error
"     Highlights trailing white space.

" Quit when a (custom) syntax file was already loaded
if exists('b:current_syntax')
  finish
endif

if !exists('g:bling_highlight_array_whitespace_error')
  let g:bling_highlight_array_whitespace_error = 0
endif
if !exists('g:bling_highlight_chan_whitespace_error')
  let g:bling_highlight_chan_whitespace_error = 0
endif
if !exists('g:bling_highlight_extra_types')
  let g:bling_highlight_extra_types = 0
endif
if !exists('g:bling_highlight_space_tab_error')
  let g:bling_highlight_space_tab_error = 0
endif
if !exists('g:bling_highlight_trailing_whitespace_error')
  let g:bling_highlight_trailing_whitespace_error = 0
endif

syn case match

syn keyword     blingDirective         package import
syn keyword     blingDeclaration       var const typedef
syn keyword     blingDeclType          struct interface

hi def link     blingDirective         Statement
hi def link     blingDeclaration       Keyword
hi def link     blingDeclType          Keyword

" Keywords within functions
syn keyword     blingStatement         defer bling blingto return break continue fallthrough
syn keyword     blingConditional       if else switch select
syn keyword     blingLabel             case default
syn keyword     blingRepeat            for range

hi def link     blingStatement         Statement
hi def link     blingConditional       Conditional
hi def link     blingLabel             Label
hi def link     blingRepeat            Repeat

" Predefined types
syn keyword     blingType              chan map bool string error
syn keyword     blingSignedInts        int int8 int16 int32 int64 rune
syn keyword     blingUnsignedInts      byte uint uint8 uint16 uint32 uint64 uintptr
syn keyword     blingFloats            float32 float64
syn keyword     blingComplexes         complex64 complex128

hi def link     blingType              Type
hi def link     blingSignedInts        Type
hi def link     blingUnsignedInts      Type
hi def link     blingFloats            Type
hi def link     blingComplexes         Type

" Treat func specially: it's a declaration at the start of a line, but a type
" elsewhere. Order matters here.
syn match       blingType              /\<fun\>/
syn match       blingDeclaration       /^fun\>/

" Predefined functions and values
syn keyword     blingBuiltins          append cap close complex copy delete imag len
syn keyword     blingBuiltins          make new panic print println real recover
syn keyword     blingConstants         iota true false nil

hi def link     blingBuiltins          Keyword
hi def link     blingConstants         Keyword

" Comments; their contents
syn keyword     blingTodo              contained TODO FIXME XXX BUG
syn cluster     blingCommentGroup      contains=blingTodo
syn region      blingComment           start="/\*" end="\*/" contains=@blingCommentGroup,@Spell
syn region      blingComment           start="//" end="$" contains=@blingCommentGroup,@Spell

hi def link     blingComment           Comment
hi def link     blingTodo              Todo

" Bling escapes
syn match       blingEscapeOctal       display contained "\\[0-7]\{3}"
syn match       blingEscapeC           display contained +\\[abfnrtv\\'"]+
syn match       blingEscapeX           display contained "\\x\x\{2}"
syn match       blingEscapeU           display contained "\\u\x\{4}"
syn match       blingEscapeBigU        display contained "\\U\x\{8}"
syn match       blingEscapeError       display contained +\\[^0-7xuUabfnrtv\\'"]+

hi def link     blingEscapeOctal       blingSpecialString
hi def link     blingEscapeC           blingSpecialString
hi def link     blingEscapeX           blingSpecialString
hi def link     blingEscapeU           blingSpecialString
hi def link     blingEscapeBigU        blingSpecialString
hi def link     blingSpecialString     Special
hi def link     blingEscapeError       Error

" Strings and their contents
syn cluster     blingStringGroup       contains=blingEscapeOctal,blingEscapeC,blingEscapeX,blingEscapeU,blingEscapeBigU,blingEscapeError
syn region      blingString            start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@blingStringGroup
syn region      blingRawString         start=+`+ end=+`+

hi def link     blingString            String
hi def link     blingRawString         String

" Characters; their contents
syn cluster     blingCharacterGroup    contains=blingEscapeOctal,blingEscapeC,blingEscapeX,blingEscapeU,blingEscapeBigU
syn region      blingCharacter         start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=@blingCharacterGroup

hi def link     blingCharacter         Character

" Regions
syn region      blingBlock             start="{" end="}" transparent fold
syn region      blingParen             start='(' end=')' transparent

" Integers
syn match       blingDecimalInt        "\<\d\+\([Ee]\d\+\)\?\>"
syn match       blingHexadecimalInt    "\<0x\x\+\>"
syn match       blingOctalInt          "\<0\o\+\>"
syn match       blingOctalError        "\<0\o*[89]\d*\>"

hi def link     blingDecimalInt        Integer
hi def link     blingHexadecimalInt    Integer
hi def link     blingOctalInt          Integer
hi def link     Integer             Number

" Floating point
syn match       blingFloat             "\<\d\+\.\d*\([Ee][-+]\d\+\)\?\>"
syn match       blingFloat             "\<\.\d\+\([Ee][-+]\d\+\)\?\>"
syn match       blingFloat             "\<\d\+[Ee][-+]\d\+\>"

hi def link     blingFloat             Float

" Imaginary literals
syn match       blingImaginary         "\<\d\+i\>"
syn match       blingImaginary         "\<\d\+\.\d*\([Ee][-+]\d\+\)\?i\>"
syn match       blingImaginary         "\<\.\d\+\([Ee][-+]\d\+\)\?i\>"
syn match       blingImaginary         "\<\d\+[Ee][-+]\d\+i\>"

hi def link     blingImaginary         Number

" Spaces after "[]"
if bling_highlight_array_whitespace_error != 0
  syn match blingSpaceError display "\(\[\]\)\@<=\s\+"
endif

" Spacing errors around the 'chan' keyword
if bling_highlight_chan_whitespace_error != 0
  " receive-only annotation on chan type
  syn match blingSpaceError display "\(<-\)\@<=\s\+\(chan\>\)\@="
  " send-only annotation on chan type
  syn match blingSpaceError display "\(\<chan\)\@<=\s\+\(<-\)\@="
  " value-ignoring receives in a few contexts
  syn match blingSpaceError display "\(\(^\|[={(,;]\)\s*<-\)\@<=\s\+"
endif

" Extra types commonly seen
if bling_highlight_extra_types != 0
  syn match blingExtraType /\<bytes\.\(Buffer\)\>/
  syn match blingExtraType /\<io\.\(Reader\|Writer\|ReadWriter\|ReadWriteCloser\)\>/
  syn match blingExtraType /\<reflect\.\(Kind\|Type\|Value\)\>/
  syn match blingExtraType /\<unsafe\.Pointer\>/
endif

" Space-tab error
if bling_highlight_space_tab_error != 0
  syn match blingSpaceError display " \+\t"me=e-1
endif

" Trailing white space error
if bling_highlight_trailing_whitespace_error != 0
  syn match blingSpaceError display excludenl "\s\+$"
endif

hi def link     blingExtraType         Type
hi def link     blingSpaceError        Error

" Search backwards for a global declaration to start processing the syntax.
"syn sync match blingSync grouphere NONE /^\(const\|var\|typedef\|fun\)\>/

" There's a bug in the implementation of grouphere. For now, use the
" following as a more expensive/less precise workaround.
syn sync minlines=500

let b:current_syntax = 'bling'

" vim: sw=2 sts=2 et
