# --- Autocomplete
source <(kubectl completion bash 2>/dev/null)
complete -F __start_kubectl k

alias k=kubectl     # gold standard

# --- Namespace shortcuts
alias setns='kubectl config set-context --current --namespace='
alias kubens='kubectl config set-context --current --namespace '
alias kubectx='kubectl config use-context '

# --- List namespaces & context
alias kns='kubectl get ns'
alias kctx='kubectl config get-contexts'
alias kcur='kubectl config current-context'

# --- Apply / Delete with confirmation
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kdel='kubectl delete'

# --- Pods
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods -A'
alias kdp='kubectl describe pod'
alias kex='kubectl exec -it'

# --- Deployments
alias kgd='kubectl get deploy'
alias kdd='kubectl describe deploy'
alias krsd='kubectl rollout status deploy'

# --- Logs
alias kl='kubectl logs'
alias klf='kubectl logs -f'

# Tail logs of the newest pod for a deployment
klast() {
  DEPLOY="$1"
  POD=$(kubectl get pods --sort-by=.metadata.creationTimestamp \
        | grep "$DEPLOY" | tail -1 | awk '{print $1}')
  echo "📄 Tailing logs for pod: $POD"
  kubectl logs -f "$POD"
}

# Exec into the newest pod of a deployment
kexec() {
  DEPLOY="$1"
  POD=$(kubectl get pods --sort-by=.metadata.creationTimestamp \
        | grep "$DEPLOY" | tail -1 | awk '{print $1}')
  kubectl exec -it "$POD" -- bash
}

# --- Quick port-forward
kpf() {  # usage: kpf svc/myservice 8080:80
  kubectl port-forward "$1" "$2"
}

# --- Switch context AND namespace together
kcns() {  # kcns <context> <namespace>
  kubectl config use-context "$1"
  kubectl config set-context --current --namespace="$2"
  echo "Switched to context=$1 and namespace=$2"
}

# --- View K8s resources quickly
alias kga='kubectl get all'
alias kgaa='kubectl get all -A'

# --- Switch namespace interactively (fzf)
knsf() {
  NS=$(kubectl get ns --no-headers | awk '{print $1}' | fzf)
  kubectl config set-context --current --namespace="$NS"
  echo "Namespace → $NS"
}

# --- Switch context interactively (fzf)
kctxf() {
  CTX=$(kubectl config get-contexts --no-headers | awk '{print $1}' | fzf)
  kubectl config use-context "$CTX"
  echo "Context → $CTX"
}

# --- Restart a deployment
krestart() {  # krestart <deploy>
  kubectl rollout restart deployment "$1"
}

# --- YAML helpers
alias ky='kubectl apply -f'
alias kgy='kubectl get -o yaml'
alias kdy='kubectl delete -f'

# --- Debug ephemeral container
kdebug() {  # kdebug <pod> <container>
  kubectl debug -it "$1" --image=busybox --target="$2"
}

