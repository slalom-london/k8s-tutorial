#!/bin/bash
mkdir ~/.kube
mv ./build-scripts/kubeconfig ~/.kube/config

#decrypt the large secrets
{Your openssl command from the encrypt secrets stage here}

# run the script to get the secrets as environment variables
source ./large-secrets.txt
export $(cut -d= -f1 ./large-secrets.txt)


# Set kubernetes secrets
./kubectl config set {Your cluster url here}.certificate-authority-data "$CERTIFICATE_AUTHORITY_DATA"
./kubectl config set {Your cluster url here}.client-certificate-data "$CLIENT_CERTIFICATE_DATA"
./kubectl config set {Your cluster url here}.client-key-data "$CLIENT_KEY_DATA"
./kubectl config set {Your cluster url here}.password "$KUBE_PASSWORD"
./kubectl config set {Your cluster url here}-basic-auth.password "$KUBE_PASSWORD"

# set AWS secrets
mkdir ~/.aws
touch ~/.aws/credentials
echo '[default]' >> ~/.aws/credentials
echo "aws_access_key_id = $AWS_KEY">> ~/.aws/credentials
echo "aws_secret_access_key = $AWS_SECRET_KEY" >> ~/.aws/credentials

# set AWS region
touch ~/.aws/config
echo '[default]' >> ~/.aws/config
echo "output = json">> ~/.aws/config
echo "region = eu-west-1" >> ~/.aws/config
