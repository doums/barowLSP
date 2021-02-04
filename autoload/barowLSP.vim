" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at https://mozilla.org/MPL/2.0/.

if exists('g:barow_lsp')
  finish
endif
let g:barow_lsp = 1

function barowLSP#error()
  let coc_error = get(b:coc_diagnostic_info, 'error', 0)
  let ale_count = ale#statusline#Count(bufnr())
  let total = coc_error + get(ale_count, 'error', 0) + get(ale_count, 'style_error', 0)
  if total > 0 | return total | else | return ''
endfunction

function barowLSP#warning()
  let coc_warning = get(b:coc_diagnostic_info, 'warning', 0)
  let ale_count = ale#statusline#Count(bufnr())
  let total = coc_warning + get(ale_count, 'warning', 0) + get(ale_count, 'style_warning', 0)
  if total > 0 | return total | else | return ''
endfunction

function barowLSP#info()
  let coc_info = get(b:coc_diagnostic_info, 'information', 0)
  let ale_count = ale#statusline#Count(bufnr())
  let total = coc_info + get(ale_count, 'info', 0)
  if total > 0 | return total | else | return ''
endfunction

function barowLSP#hint()
  let hint = get(b:coc_diagnostic_info, 'hint', 0)
  if hint > 0 | return hint | else | return ''
endfunction

function barowLSP#coc_status()
  return get(g:, 'coc_status', '')
endfunction

function barowLSP#ale_status()
  if ale#engine#IsCheckingBuffer(bufnr())
    return 'ALE..'
  endif
  return ''
endfunction

augroup barowLSP
  autocmd!
  autocmd User CocStatusChange,CocDiagnosticChange call barow#update()
  autocmd User ALELintPre,ALELintPost,ALEJobStarted call barow#update()
augroup END
