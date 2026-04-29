Ejecutar entorno Kubernetes con Helm:
helm upgrade --install ptin-test .   -f values.yaml   -f values-dev.yaml   --namespace testing   --create-namespace   --wait   --timeout 5m0s

Eliminar entorno Kubernetes con Helm:
helm uninstall ptin-test -n testing

Por si sale algun error a la hora de ejecutar alguno de los dos comandos:
Exportamos esta variable (export KUBECONFIG=/etc/rancher/k3s/k3s.yaml) al bashrc
