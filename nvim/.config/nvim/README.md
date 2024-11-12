you need to install delve (go debugger): https://github.com/go-delve/delve/tree/master/Documentation/installation
you need to install fonts: i have nerd
you need to install ghc, haskell-language-server, hlint, stylish-haskell, stack - for haskell
you need to install yaml server: npm install -g yaml-language-server (now i'm not 100% sure if this is needed, as i've added yaml to the list of servers in lspconfig)
to configure schemaStore: https://github.com/b0o/SchemaStore.nvim

For reinstalling plugins i was doing:
1. :PackerClean
2. :PackerInstall

but that didn't help with my problem, had to manually remove 'site' folder in:
~/.local/share/nvim


TODOs:
1. install & configure: which-key: https://github.com/folke/which-key.nvim
