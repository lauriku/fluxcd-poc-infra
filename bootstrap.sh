#!/usr/bin/env bash
gcloud container clusters get-credentials lauriku-gke --zone europe-north1-a --project lauriku-gke

helm3 repo add fluxcd https://charts.fluxcd.io
kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/master/deploy/crds.yaml
kubectl create ns flux

ssh-keygen -q -N "" -f ./flux-identity
kubectl -n flux create secret generic flux-ssh --from-file=./flux-identity

helm3 upgrade -i flux fluxcd/flux \
   --set git.url=git@github.com:lauriku/fluxcd-presentation.git \
   --set git.branch=main \
   --set git.secretName=flux-ssh \
   --set git.pollInterval=1m \
   --set syncGarbageCollection.enabled=true \
   --namespace flux

helm3 upgrade -i helm-operator fluxcd/helm-operator \
  --set git.ssh.secretName=flux-ssh \
  --set helm.versions=v3 \
  --namespace flux

sleep 30
fluxctl identity --k8s-fwd-ns flux

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
