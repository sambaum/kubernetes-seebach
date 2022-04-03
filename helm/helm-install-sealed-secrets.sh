#!/bin/bash
parent_path=$(
	cd "$(dirname "${BASH_SOURCE[0]}")"
	pwd -P
)

cd "$parent_path"

helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
helm repo update

helm install sealed-secrets sealed-secrets/sealed-secrets --set fullnameOverride=sealed-secrets-controller

# brew install kubeseal

# kubeseal <mysecret.json >mysealedsecret.json --controller-namespace=default
# OR:
#kubectl create secret generic secretname --dry-run=client --from-literal=mysecretkey=mysecretvalue -o yaml | \
#kubeseal \
#  --controller-name=sealed-secrets-controller \
#  --controller-namespace=default \
#  --format yaml > mysealedsecret.yaml

# Backup: kubectl get secret -l sealedsecrets.bitnami.com/sealed-secrets-key -o yaml >master.key
# Restore: kubectl apply -f master.key
#          kubectl delete pod -l name=sealed-secrets-controller
