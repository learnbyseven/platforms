helm repo add tekton https://tektoncd.github.io/helm-charts
helm repo update
kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
helm install tekton-pipelines tekton/pipelines --namespace tekton-pipelines --create-namespace --set installCRDs=false
helm install tekton-triggers tekton/triggers --namespace tekton-pipelines --create-namespace
helm install tekton-dashboard tekton/dashboard --namespace tekton-pipelines --create-namespace
kubectl get pods -n tekton-pipelines
