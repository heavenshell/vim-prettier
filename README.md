# vim-prettier

[![Build Status](https://travis-ci.org/heavenshell/vim-prettier.svg?branch=master)](https://travis-ci.org/heavenshell/vim-prettier)

Prettier for Vim.

![Asynchronous format](./assets/vim-prettier.gif)

`vim-pritter` is a wrapper of [Prettier](https://github.com/prettier/prettier).

## Dependencies

`vim-prettier` use [prettier-eslint-cli](https://github.com/prettier/prettier-eslint-cli).

Install [prettier-eslint-cli](https://github.com/prettier/prettier-eslint-cli) global or local.

## Usage

Open JavaScript file and just execute `:Prettier`.

That's it.

## Motivation

Pritter official document recommends like followings.

```viml
autocmd FileType javascript set formatprg=prettier\ --stdin
```

`set formatprg` runs sync and it's too slow.

`vim-pritter` runs asynchronously and doesn't block editing.

## License

New BSD License
