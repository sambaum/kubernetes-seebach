#!/bin/bash
parent_path=$(
	cd "$(dirname "${BASH_SOURCE[0]}")"
	pwd -P
)

cd "$parent_path"

helm repo add k8s-at-home https://k8s-at-home.com/charts/
helm repo update

helm install tandoor-recipes k8s-at-home/recipes -f tandoor-recipes.yaml
