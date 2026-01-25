#!/usr/bin/env bash

# Works in bash and Zsh when sourced using an absolute path
if [[ -n "${BASH_SOURCE[0]}" ]]; then
  # Bash is running
  SCRIPT_PATH="${BASH_SOURCE[0]}"
else
  # Zsh is running
  SCRIPT_PATH="${0:A:h}"
fi

echo "SCRIPT_DIR = $SCRIPT_DIR"

echo TERRAFORM 
source "${SCRIPT_DIR}/tf.profile"

echo GCP
source "${SCRIPT_DIR}/gcp.profile"

echo GIT
source "${SCRIPT_DIR}/git.profile"

echo DOCKER
source "${SCRIPT_DIR}/docker.profile"

# echo KUBE
# source "${SCRIPT_DIR}/kube.profile"

echo WORK 
source "${SCRIPT_DIR}/work.profile"

echo PROMPT
source "${SCRIPT_DIR}/prompt.profile"