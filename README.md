1. i dont have .gitconfig here, which i probably should have
should add those aliased to .gitconfig (one for local branches one for remote):

	[alias]
	 lg1 = git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all
	 lg2 = git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'
	 lg = lg1

2. i should check fzf configuration (in .zshrc) - where i had to add it to plugin section
 but it also relies on pulling fzf repo from git and installing it <how to deal with it??>
3. and i think i have some fzf configuration potentially  referring to z, which need to be installed


To setup macos i need:
- install git
- install kdiff and configure git (user, email, mergetools)
- install go, jvm, sbt, nvm, node, clojure
- install fzf, Ack, ripgrep (rg: required for telescope), fd (brew install ripgrep; brew install fd)
- install z
- install warp: set theme
- install oh-my-zsh (plugins for it defined in .zshrc: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/)
- install NerdFonts from: https://www.nerdfonts.com/font-downloads?utm_source=pocket_saves, I'm currently using: (CommicShannMono)

