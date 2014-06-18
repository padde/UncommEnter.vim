" Author: Patrick Oscity <patrick.oscity@gmail.com>
" Version: 1.0

" License: {{{
"   Copyright (c) 2013
"   All rights reserved.
"
"   Redistribution and use of this software in source and binary forms, with
"   or without modification, are permitted provided that the following
"   conditions are met:
"
"   * Redistributions of source code must retain the above
"     copyright notice, this list of conditions and the
"     following disclaimer.
"
"   * Redistributions in binary form must reproduce the above
"     copyright notice, this list of conditions and the
"     following disclaimer in the documentation and/or other
"     materials provided with the distribution.
"
"   * Neither the name of Gergely Kontra or Eric Van Dewoestine nor the names
"   of its contributors may be used to endorse or promote products derived
"   from this software without specific prior written permission of Gergely
"   Kontra or Eric Van Dewoestine.
"
"   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
"   IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
"   THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
"   PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
"   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
"   EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
"   PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
"   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
"   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
"   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
"   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
" }}}

" Description: {{{
"   UncommEnter lets you end a comment series caused by formatoption "r" by
"   simply hitting <cr> (Enter) on the last empty line of a comment.
"
"   http://github.com/padde/UncommEnter.vim
" }}}

" Global Variables {{{
if !exists("g:UncommEnterEnabled")
  let g:UncommEnterEnabled = 1
endif
" }}}

" {{{ s:IsCommentLine(str)
function! s:IsCommentLine(str)
  let commentRegex='^\s*'.substitute(&commentstring,'%s','','')
  return strlen(matchstr(a:str, commentRegex)) > 0
endfunction
" }}}

" {{{ s:IsEmptyCommentLine(str)
function! s:IsEmptyCommentLine(str)
  let commentRegex='^\s*'.substitute(&commentstring,'%s','\\s*','').'$'
  return strlen(matchstr(a:str, commentRegex)) > 0
endfunction
" }}}

" Key Mappings {{{
if g:UncommEnterEnabled
  " this hack to let other <cr> mappings for other plugins cooperate
  " with UncommEnter was shamelessly copied from SuperTab, see:
  " https://github.com/ervandew/supertab
  " (c) Gergely Kontra and Eric Van Dewoestine
  let map = maparg('<cr>', 'i')
  if map =~ '<Plug>'
    let plug = substitute(map, '.\{-}\(<Plug>\w\+\).*', '\1', '')
    let plug_map = maparg(plug, 'i')
    let map = substitute(map, '.\{-}\(<Plug>\w\+\).*', plug_map, '')
  endif
  exec "inoremap <silent><script> <cr> <c-r>=<SID>UncommEnter()<cr>" . map


  " stop the comment series if the current line is only an empty comment
  " there are two exceptions, however:
  "
  "   * last line is empty comment, too (chances are the user wants to
  "     extend the comment series)
  "
  "   * next line is comment, too (we are in the middle of a comment so
  "     (the user probably will not want to exit the commen series here)
  function! s:UncommEnter()
    let currLine=line('.')
    let prevLine=currLine-1
    let nextLine=currLine+1

    if s:IsEmptyCommentLine(getline(prevLine)) == 0 &&
          \ s:IsEmptyCommentLine(getline(currLine)) == 1 &&
          \ s:IsCommentLine(getline(nextLine)) == 0
      return "\<esc>S"
    endif

    return "\<cr>"
  endfunction
endif
" }}}

" vim:ft=vim:fdm=marker
