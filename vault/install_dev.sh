helm repo add hashicorp https://helm.releases.hashicorp.com
helm search repo hashicorp/vault
kubectl create ns vault
helm -n vault install vault hashicorp/vault --set "server.dev.enabled=true"
