# vim-prettier

[![Build Status](https://travis-ci.org/heavenshell/vim-prettier.svg?branch=master)](https://travis-ci.org/heavenshell/vim-prettier)

Prettier for Vim.

![Asynchronous format](./assets/vim-prettier.gif)

`vim-pritter` is a wrapper of Pritter.

Pritter official document recommends like followings.

```viml
autocmd FileType javascript set formatprg=prettier\ --stdin
```

`set formatprg` runs sync and it's too slow.

`vim-pritter` runs asynchronously and doesn't block editing.
