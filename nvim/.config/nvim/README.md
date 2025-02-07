you need to install delve (go debugger): https://github.com/go-delve/delve/tree/master/Documentation/installation
you need to install fonts: i have nerd
you need to install ghc, haskell-language-server, hlint, stylish-haskell, stack - for haskell
you need to install cljfmt, clj-kondo - for clojure (also install asdf manager to manage versions - this manager is used across languages eg npm maybe scala)
   brew install asdf
   asdf plugin add cljfmt https://github.com/b-social/asdf-cljfmt.git
   asdf plugin add clj-kondo
      asdf list all cljfmt
      asdf list all clj-kondo
      asdf install cljfmt latest
you need to install yaml server: npm install -g yaml-language-server (now i'm not 100% sure if this is needed, as i've added yaml to the list of servers in lspconfig)
to configure schemaStore: https://github.com/b0o/SchemaStore.nvim

For reinstalling plugins i was doing:
1. :PackerClean
2. :PackerInstall

but that didn't help with my problem, had to manually remove 'site' folder in:
~/.local/share/nvim

to configure indetation per project bases:
1. create .editorconfig file in the root of the project
2. add the following:
```
root = true

[*]
indent_style = space
indent_size = 2
```

or per file type:
```
[*.{js,jsx,ts,tsx}]
indent_style = space
indent_size = 2
```

to format buffer to json (via jq):
```
:%!jq .
```

TODOs:
1. install & configure: which-key: https://github.com/folke/which-key.nvim
