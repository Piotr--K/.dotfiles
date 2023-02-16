alias gs='git -c delta.side-by-side=true'
alias gsd='gs diff'
alias gsds='gs diff --staged'
#alias
alias alias-source="source ~/.bash_profile"
alias alias-vim="vim ~/.bash_aliases"
#folders
alias ls-dir="ls -al | grep ^d" #  listing of directories in the current directory
alias f="find . |grep " # finding file recursively in current dir
alias h="history|grep " # searching through history for command
#git
alias gc="git commit -m" # git commit
#fzf
alias fzfp="fzf --preview 'cat {}'"
alias fzfv='nvim $(fzfp)'
