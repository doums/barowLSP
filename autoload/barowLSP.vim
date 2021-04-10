" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at https://mozilla.org/MPL/2.0/.

if exists('g:barow_lsp')
  finish
endif
let g:barow_lsp = 1

let s:save_cpo = &cpo
set cpo&vim

let s:ale_linting = 0
let s:ale_fixing = 0

function! barowLSP#ale_linting(state)
  let s:ale_linting = a:state
endfunction

function! barowLSP#ale_fixing(state)
  let s:ale_fixing = a:state
endfunction

function! s:coc_count(type)
  if exists('b:coc_diagnostic_info')
    return get(b:coc_diagnostic_info, a:type, 0)
  endif
  return 0
endfunction

function! s:ale_counts()
  " Because ale#statusline#Count is an autoload function,
  " chances are that it is not yet loaded during this call.
  " Checking with exists('*ale#statusline#Count') could result in a false negative.
  " Base the check on the presence of g:loaded_ale instead.
  if exists('g:loaded_ale') && g:loaded_ale == 1
    return ale#statusline#Count(bufnr())
  endif
  return {}
endfunction

function! s:lsp_count(type)
  if has('nvim-0.5')
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
      return luaeval('vim.lsp.diagnostic.get_count(0, "'.a:type.'")')
    endif
  endif
  return 0
endfunction

function! s:ycm_count(type)
  if exists('g:loaded_youcompleteme') && g:loaded_youcompleteme == 1
    if a:type == 'error'
      return youcompleteme#GetErrorCount()
    endif
    if a:type == 'warning'
      return youcompleteme#GetWarningCount()
    endif
  endif
  return 0
endfunction

function barowLSP#error()
  let coc_error = s:coc_count('error')
  let ale_counts = s:ale_counts()
  let total = coc_error + get(ale_counts, 'error', 0) + get(ale_counts, 'style_error', 0) + s:ycm_count('error') + s:lsp_count('Error')
  if total > 0 | return total | else | return '' | endif
endfunction

function barowLSP#warning()
  let coc_warning = s:coc_count('warning')
  let ale_counts = s:ale_counts()
  let total = coc_warning + get(ale_counts, 'warning', 0) + get(ale_counts, 'style_warning', 0) + s:ycm_count('warning') + s:lsp_count('Warning')
  if total > 0 | return total | else | return '' | endif
endfunction

function barowLSP#info()
  let coc_info = s:coc_count('information')
  let ale_counts = s:ale_counts()
  let total = coc_info + get(ale_counts, 'info', 0) + s:lsp_count('Information')
  if total > 0 | return total | else | return '' | endif
endfunction

function barowLSP#hint()
  let hint = s:coc_count('hint') + s:lsp_count('Hint')
  if hint > 0 | return hint | else | return '' | endif
endfunction

function barowLSP#coc_status()
  return get(g:, 'coc_status', '')
endfunction

function barowLSP#ale_status()
  if s:ale_linting
    return 'ALE L'
  elseif s:ale_fixing
    return 'ALE F'
  elseif exists('g:loaded_ale') && g:loaded_ale == 1
        \&& ale#engine#IsCheckingBuffer(bufnr())
    return 'ALE..'
  endif
  return ''
endfunction

function barowLSP#nvim_lsp_status()
  return luaeval('require"lsp_status".status()')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
