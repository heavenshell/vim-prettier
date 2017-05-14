# vim-prettier

[![Build Status](https://travis-ci.org/heavenshell/vim-prettier.svg?branch=master)](https://travis-ci.org/heavenshell/vim-prettier)

Prettier for Vim.

![Asynchronous format](./assets/vim-prettier.gif)

`vim-pritter` is a wrapper of [Prettier](https://github.com/prettier/prettier).

## Dependencies

`vim-prettier` use [prettier-eslint-cli](https://github.com/prettier/prettier-eslint-cli).

Install [prettier-eslint-cli](https://github.com/prettier/prettier-eslint-cli) global or local.

## Usage

### Invoke manually

Open JavaScript file and just execute `:Prettier`.

That's it.

### Automatically format on save

```viml
autocmd BufWritePost *.js,*.jsx call prettier#run(1)
```

## Motivation

Pritter official document recommends like followings.

```viml
autocmd FileType javascript set formatprg=prettier\ --stdin
```

`set formatprg` runs sync and it's too slow.

`vim-pritter` runs asynchronously and doesn't block cursor moving.

## License

New BSD License
