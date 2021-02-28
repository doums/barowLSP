" This Source Code Form is subject to the terms of the Mozilla Public
" License, v. 2.0. If a copy of the MPL was not distributed with this
" file, You can obtain one at https://mozilla.org/MPL/2.0/.

if exists('g:barowLSP_plugin')
  finish
endif
let g:barowLSP_plugin = 1

let s:save_cpo = &cpo
set cpo&vim

augroup barowLSP
  autocmd!
  autocmd User CocStatusChange,CocDiagnosticChange call barow#update()
  autocmd User ALEJobStarted call barow#update()
  autocmd User ALELintPre let s:ale_linting = 1 | call barow#update()
  autocmd User ALELintPost let s:ale_linting = 0 | call barow#update()
  autocmd User ALEFixPre let s:ale_fixing = 1 | call barow#update()
  autocmd User ALEFixPost let s:ale_fixing = 0 | call barow#update()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
