alias tfmt="terraform fmt"
alias tfa="terraform apply -auto-approve"
alias tfp="terraform plan"
alias tfi="terraform init"
alias tfd="terraform destroy -auto-approve"
alias tfl="terraform state list"
alias tfl="terraform validate"


function tfpp() { terraform plan -out=tf"${1}"plan -var env=${1}; }
function tfap { terraform apply -auto-approve tf${1}plan; }
function tfdp() { terraform destroy -auto-approve -var env=${1}; }


alias tfinit='touch {variables.tf,main.tf,outputs.tf,resources.tf,terraform.tfvars}'

alias wsl='terraform workspace list'
alias wsc='terraform workspace new'
alias wss='terraform workspace select'
alias wsd='terraform workspace delete'
alias ws='terraform workspace show'
