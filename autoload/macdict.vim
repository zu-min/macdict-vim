let s:save_cpo = &cpo
set cpo&vim

" set program path
if executable(expand('<sfile>:p:h:h')."/autoload/dict")
  let s:macdict_prg = "r!".expand('<sfile>:p:h:h')."/autoload/dict "
else
  echo "Before using macdict-vim, You need compile dict.m in the plugin directory."
endif

" set window option
if !exists('g:macdict_window_size')
  let g:macdict_window_size = 'botright 8split'
endif

let s:last_popup_window = 0

" consult mac internal dictionaries
function! macdict#consul(opt, arg)
  if !has("mac")
    echo "Sorry. macdict.vim is only for Mac OSX User."
    return
  endif
  call popup_close(s:last_popup_window)
  exec s:macdict_prg a:opt a:arg
  let s:last_popup_window = popup_create(s:macdict_prg, {})
endfunction

" close output
function! macdict#close()
  " silent exec ":bdelete MacDictBuffer"
  call popup_close(s:last_popup_window)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
