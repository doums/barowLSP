## barowLSP

A module to display the summary of LSP diagnostics in [barow](https://github.com/doums/barow).

Supported LSP clients:
- [LSP](https://neovim.io/doc/user/lsp.html)
- [ALE](https://github.com/dense-analysis/ale)
- [Coc](https://github.com/neoclide/coc.nvim)
- [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe)

### dependency
Use [lsp_status](https://github.com/doums/lsp_status) to get status for nvim LSP with `barowLSP#nvim_lsp_status`.

### usage

```
" .vimrc/init.vim
" ...

Plug 'doums/barow'
Plug 'doums/barowLSP'
" ...

" barow
let g:barow = {
      \  'modules': [
      \    [ 'barowGit#branch', 'BarowHint' ],
      \    [ 'barowLSP#error', 'BarowError' ],
      \    [ 'barowLSP#warning', 'BarowWarning' ],
      \    [ 'barowLSP#info', 'BarowInfo' ],
      \    [ 'barowLSP#hint', 'BarowHint' ],
      \    [ 'barowLSP#coc_status', 'StatusLine' ],
      \    [ 'barowLSP#ale_status', 'StatusLine' ],
      \    [ 'barowLSP#nvim_lsp_status', 'StatusLine' ]
      \  ]
      \}
```

### license
Mozilla Public License 2.0
