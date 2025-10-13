helm install kagent-crds oci://ghcr.io/kagent-dev/kagent/helm/kagent-crds --namespace kagent  --create-namespace
export ANTHROPIC_API_KEY=your_api_key
helm upgrade --install kagent oci://ghcr.io/kagent-dev/kagent/helm/kagent --namespace kagent --set providers.default=anthropic --set providers.anthropic.apiKey=$ANTHROPIC_API_KEY
##kubectl port-forward svc/kagent-ui -n kagent 8080:8080
##https://www.cloudnativedeepdive.com/kagent-claude-k8s-your-private-agentic-troubleshooter/
