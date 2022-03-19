#!/bin/bash
parent_path=$(
	cd "$(dirname "${BASH_SOURCE[0]}")"
	pwd -P
)

cd "$parent_path"

helm repo add fairwinds-stable https://charts.fairwinds.com/stable

helm install vpa fairwinds-stable/vpa --namespace vpa --create-namespace
helm install goldilocks --namespace goldilocks fairwinds-stable/goldilocks --create-namespace

kubectl label ns default goldilocks.fairwinds.com/enabled=true