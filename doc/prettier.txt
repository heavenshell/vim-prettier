*prettier*	Pritter for Vim.

Version: 0.1.0
Author: Shinya Ohynagi <sohyanagi@gmail.com>
Repository: http://github.com/heavenshell/vim-pritter/
License: BSD, see LICENSE for more details.

==============================================================================
CONTENTS						*prettier-contents*

Introduction		|prettier-introduction|
Install			|prettier-install|
Usage			|prettier-usage|
Changelogs		|prettier-changelog|

==============================================================================
INTRODUCTION						*prettier-introduction*

|pritter| is a wrapper of Pritter.

Pritter official document recommends like followings.
>
  autocmd FileType javascript set formatprg=prettier\ --stdin
<

`set formatprg` runs sync, but it's too slow.

|vim-pritter| runs asynchronously and doesn't block editing.

==============================================================================
INSTALL							*prettier-install*

Install the distributed files into Vim runtime directory which is usually
~/.vim/, or $HOME/vimfiles on Windows.

If you use built in `package`, you should extract the
file into '~/.vim/pack/*/start' directory.

==============================================================================
TUTORIAL						*prettier-usage*
>
  :Pritter
>
`:Pritter` format JavaScript code in current buffer using Pritter.

==============================================================================
VARIABLES					*prettier-variables*

==============================================================================
CHANGELOG						*prettier-changelog*

0.1.0
2017-05-01
- First release

vim:tw=78:ts=8:ft=help:norl:noet:fen:fdl=0:
