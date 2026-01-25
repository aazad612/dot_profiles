alias cdn="cd /Users/johneyaazad/work/gcp-healthcare-data-landing-zone/infra/03-networking"
alias cdj="cd /Users/johneyaazad/work/gcp-healthcare-data-landing-zone/infra/06-workloads/jenkins"
alias cdw="cd /Users/johneyaazad/work/gcp-healthcare-data-landing-zone/infra"
alias cd5="cd /Users/johneyaazad/work/gcp-healthcare-data-landing-zone/infra/05-domains"
alias cdso="cd /Users/johneyaazad/work/gcp-healthcare-data-landing-zone/infra/06-workloads/shared_ops_new"
alias cd6="cd ~/work/gcp-healthcare-data-landing-zone/infra/06-workloads/clinical_synthea"
alias cdd="cd ~//work/gcp-healthcare-data-platform"


rmempty() {
  find . -type d -empty -delete
  echo "Recursive cleanup complete."
}