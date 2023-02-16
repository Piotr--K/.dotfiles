1. i dont have .gitconfig here, which i probably should have
should add those aliased to .gitconfig (one for local branches one for remote):

	[alias]
	 lg1 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all
	 lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'
	 lg = lg1

2. i should also change nvim configuration, to use custom folders for all plugins etc
rather that one file like its now
3. i should check fzf configuration (in .zshrc) - where i had to add it to plugin section
 but it also relies on pulling fzf repo from git and installing it <how to deal with it??>
4. and i think i have some fzf configuration potentially  referring to z, which need to be installed

