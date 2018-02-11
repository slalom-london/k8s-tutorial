#!/bin/bash

#script to recursively travel a dir of n levels

function traverse() {   

for file in `ls $1`
do
    #current=${1}{$file}
    if [ ! -d ${1}${file} ] ; then
    echo ''
    else

        echo -e "${GREEN}==== Deploying TF in ${1}${file} ====${NC}"
        cd ${1}/${file}

        if ls | grep -q .tf; 
        then
            terraform init
            terraform plan
            terraform apply
        fi

         echo -e "${GREEN}==== Done deploying TF in ${1}${file} ====${NC}"

        traverse "${1}/${file}"
    fi
done
}


GREEN='\033[0;32m'
NC='\033[0;0m'
export PATH=$PATH:$(pwd)

echo -e "${GREEN}==== Deploying terraform ====${NC}"

traverse ../

for f in $(find ./ -name '*.yaml' -or -name '*.yml'); do kubectl apply -f $f --validate=false; done
echo -e "${GREEN}==== Done deploying terraform  ====${NC}"
echo ''





