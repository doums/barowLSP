## barowCoc

A module to display the summary of [Coc](https://github.com/neoclide/coc.nvim)'s diagnostics in [barow](https://github.com/doums/barow).

### usage

```
" .vimrc/init.vim
" ...

Plug 'doums/barow'
Plug 'doums/barowCoc'
" ...

let g:barow = {
      \  'modules': [
      \    [ 'barowCoc#error', 'BarowError' ],
      \    [ 'barowCoc#warn', 'BarowWarn' ],
      \    [ 'barowCoc#info', 'BarowInfo' ],
      \    [ 'barowCoc#hint', 'BarowHint' ],
      \    [ 'barowCoc#status', 'StatusLine' ]
      \  ]
      \}
```

### license
Mozilla Public License 2.0
