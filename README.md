Instalar el helm:                                                                                                                                                                                                     
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3                                                                                                                          
chmod 700 get_helm.sh                                                                                                                                                                                                  
./get_helm.sh
helm version

Instalar el nginx:                                                                                                                                                                                                     
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx                                                                                                                                                 
helm repo update                                                                                                                                                                                                       
helm install nginx-ingress ingress-nginx/ingress-nginx \
  --namespace kube-system \
  --set controller.publishService.enabled=true                                                                                                                                                                           

Instalar el argo rollouts:                                                                                                                                                                                             
  Controlador:                                                                                                                                                                                                         
  kubectl create namespace argo-rollouts                                                                                                                                                                               
  kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml                                                                                                      
  CLI:
  curl -LO https://github.com/argoproj/argo-rollouts/releases/latest/download/kubectl-argo-rollouts-linux-amd64                                                                                                        
  chmod +x ./kubectl-argo-rollouts-linux-amd64                                                                                                                                                                         
  sudo mv ./kubectl-argo-rollouts-linux-amd64 /usr/local/bin/kubectl-argo-rollouts                                                                                                                                     
  kubectl argo rollouts version  

Deshabilitar Traefik:
		Editar el servicio: 
		
		Abre el archivo /etc/systemd/system/k3s.service y asegúrate de que la línea ExecStart termine con el flag de deshabilitar: ExecStart=/usr/local/bin/k3s server --disable traefik	
		
	Aplicar cambios en el nodo:		
	
		sudo systemctl daemon-reload	
		
		sudo systemctl restart k3s		
		
	Borrar restos en el clúster:		
	
		kubectl delete svc traefik -n kube-system	
		
		kubectl delete ingressroute -A --all		
		
	Cambiar el tipo de servicio a LoadBalancer:		
	
		kubectl patch svc nginx-ingress-ingress-nginx-controller -n kube-system -p '{"spec": {"type": "LoadBalancer"}}'		
		
	Verificar que el puente esta activo:				
	
		kubectl get pods -n kube-system | grep svclb-nginx																										

Instalar Prometheus:

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts		

helm repo update	

helm install monitor prometheus-community/kube-prometheus-stack \
  -n monitoring \
  --create-namespace \
  --set grafana.sidecar.dashboards.enabled=true \
  --set prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues=false		

Para despues poder conectarnos a Grafana, necesitaremos la contrasena, la sacamos asi:

kubectl get secret --namespace monitoring monitor-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

Ejecutar entorno Kubernetes con Helm:
helm upgrade --install ptin-test .   -f values.yaml   -f values-dev.yaml   --namespace testing   --create-namespace   --wait   --timeout 5m0s

Eliminar entorno Kubernetes con Helm:
helm uninstall ptin-test -n testing

Por si sale algun error a la hora de ejecutar alguno de los dos comandos:
Exportamos esta variable (export KUBECONFIG=/etc/rancher/k3s/k3s.yaml) al bashrc
