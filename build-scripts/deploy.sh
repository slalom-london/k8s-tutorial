#!/bin/bash
GREEN='\033[0;32m'
NC='\033[0;0m'
export PATH=$PATH:$(pwd)

# Execut kubectl apply on iam role
echo -e "${GREEN}==== Deploying iam role ====${NC}"
cd kube2iam
kubectl apply -f kube2iam-ds.yaml
kubectl apply -f kube2iam-service-account-role-binding.yaml
cd ..
echo -e "${GREEN}==== Done deploying iam role ====${NC}"
echo ''

# Execute kubectl apply on ingress 
echo -e "${GREEN}==== Deploying ingress ====${NC}"
cd ingress
terraform init
terraform plan
terraform apply
kubectl apply -f alb-ingress-controller.yaml
kubectl apply -f ingress-service-account-role-binding.yaml
cd .. 
echo -e "${GREEN}==== Done deploying ingress ====${NC}"
echo ''

# Execute kubectl apply on external dns
echo -e "${GREEN}==== Deploying external dns ====${NC}"
cd external-dns
terraform init
terraform plan
terraform apply
kubectl apply -f external_dns.yaml
kubectl apply -f external-dns-service-account-role-binding.yaml
cd ..
echo -e "${GREEN}==== Done deploying external dns ====${NC}"
echo ''

# Execute kubectl apply on test application
echo -e "${GREEN}==== Deploying test app ====${NC}"
cd hello_app
kubectl apply -f hello_app_deployment.yaml --validate=false
kubectl apply -f hello_app_ingress_resource.yaml
echo -e "${GREEN}==== Done deploying test app ====${NC}"
echo ''