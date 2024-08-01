#!/bin/bash

apply () {
    cd infra || exit
    terraform init
    terraform apply --auto-approve
}

destroy () {
    cd infra || exit
    terraform destroy --auto-approve
}

case "$1" in
    "apply") apply 
    ;;
    "destroy") destroy
    ;;
esac
