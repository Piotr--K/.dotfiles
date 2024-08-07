function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}
alias gs='git -c delta.side-by-side=true'
alias gsd='gs diff'
alias gsds='gs diff --staged'
fd() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview $preview
}
fds() {
  preview="git diff --staged $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview $preview
}
#alias
alias alias-source="source ~/.bash_profile"
alias alias-vim="nvim ~/.bash_aliases"
#folders
alias ls-dir="ls -al | grep ^d" #  listing of directories in the current directory
alias f="find . |grep " # finding file recursively in current dir
alias h="history|grep " # searching through history for command
#git
alias gc="git commit -m" # git commit
alias gca="git commit --amend" # git commit ammend
alias gco="git checkout"
alias ggp='git push origin "$(git_current_branch)"'
alias gp="git pull"
alias lg='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)" --all'
alias lg2='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)"'

#fzf
alias fzfp="fzf --preview 'bat {-1} --color=always'"
alias fzfv='nvim $(fzfp)'
alias rabbit='echo "Username      : rblminer" && echo "Password      : $(kubectl get secret --namespace default rabbitmq-auth -o jsonpath="{.data.rabbitmq-password}" | base64 --decode)" && open "http://127.0.0.1:15672" && kubectl port-forward --namespace default svc/rabbitmq 15672:15672'

#kubectl
alias k='kubectl'
alias kga='kubectl get all'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kdel='kubectl delete'
alias kex='kubectl exec'
alias kl='kubectl logs'
alias kc='kubectl config'
#kubectl namespaces
alias kgn='kubectl get namespaces'
alias kns='kubectl config set-context --current --namespace'
alias kgpn='kubectl get pods -n'
alias kgsn='kubectl get svc -n'
#kubectl pods
alias kgp='kubectl get pods'
alias kgpall='kubectl get pods --all-namespaces'
alias kdp='kubectl describe pods'
alias kep='kubectl exec -it'
#kubectl services
alias kgs='kubectl get svc'
alias kds='kubectl describe svc'
#kubectl configmaps & secrets
alias kgcm='kubectl get configmap'
alias kdcm='kubectl describe configmap'
alias kgsec='kubectl get secret'
alias kdsec='kubectl describe secret'
