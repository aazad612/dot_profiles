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


