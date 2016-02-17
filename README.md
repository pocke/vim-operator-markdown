vim-operator-markdown
==================

Operators for Markdown.

Installation
============

This plugin is in need of [kana/vim-operator-user](https://github.com/kana/vim-operator-user).


### [Shougo/neobundle.vim](https://github.com/Shougo/neobundle.vim)

```vim
NeoBundle 'kana/vim-operator-user'
NeoBundle 'pocke/vim-operator-markdown'
```

### [VundleVim/Vundle.vim](https://github.com/VundleVim/Vundle.vim)

```vim
Plugin 'kana/vim-operator-user'
Plugin 'pocke/vim-operator-markdown'
```

### [tpope/vim-pathogen](https://github.com/tpope/vim-pathogen)

```sh
git clone https://github.com/kana/vim-operator-user ~/.vim/bundle/vim-operator-user
git clone https://github.com/pocke/vim-operator-markdown ~/.vim/bundle/vim-operator-markdown
```

Setting example
===========



```markdown
autocmd FileType markdown map <buffer>< <Plug>(operator-markdown-left)
autocmd FileType markdown map <buffer>> <Plug>(operator-markdown-right)
```


Usage
=========


### `<Plug>(operator-markdown-left)`

![left](https://cloud.githubusercontent.com/assets/4361134/13113218/741ed90a-d5d1-11e5-87c0-d32c79925c4a.gif)

### `<Plug>(operator-markdown-right)`

![right](https://cloud.githubusercontent.com/assets/4361134/13113217/741aefca-d5d1-11e5-92bb-831859a81319.gif)



License
===========

These codes are licensed under CC0.

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.en)
