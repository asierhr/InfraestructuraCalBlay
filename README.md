# 🏗️ InfraestructuraCalBlay

Infraestructura desarrollada para un proyecto con la empresa **Cal Blay**, diseñada para ser escalable y monitorizable en tiempo real. El despliegue está automatizado usando **Docker**, **Kubernetes** y **GitHub Actions**, y la monitorización se realiza con **Grafana** y **Prometheus**.

---
## 🏢 Arquitectura general

El proyecto se monta sobre un **cluster de Kubernetes** configurado sobre **Proxmox**.  
- **Cluster Kubernetes:** 3 máquinas, una de ellas configurada como **master** y las otras 2 como **workers**.  
- **Servidor de archivos:** Un servidor adicional se utiliza como servidor **NFS** para almacenamiento compartido.  

---
## ☸️ Kubernetes

El cluster está organizado como un **cluster multientorno**, con dos entornos principales:

1. **Testing/QA:**  
   - Entorno de desarrollo y pruebas.  
   - Permite que los desarrolladores puedan probar sus funcionalidades localmente sin afectar otros servicios.
   - Permite validar cambios antes de desplegar en producción. 

2. **Producción:**  
   - Entorno estable donde se ejecutan las aplicaciones finales.  
   - Garantiza alta disponibilidad y rendimiento.  

### Caracteristicas interesantes

1. **Cluster de PostgreSQL dentro de cada entorno**  
	- Cada entorno cuenta con su propio cluster de PostgreSQL para garantizar **alta disponibilidad y persistencia** entre máquinas.  
	- La configuración incluye **pods de lectura/escritura y solo lectura**, optimizando el rendimiento de la aplicación.  
  
2. **Nginx como reverse proxy en el frontend**  
	- Maneja las solicitudes entrantes y balancea la carga entre los servicios del cluster.  
	- Ayuda a prevenir problemas de **CORS** y mejora la seguridad del frontend.
  
3. **Horizontal Pod Autoscaler (HPA)**  
	- Escala automáticamente los pods según la carga.  
	- Garantiza **rendimiento y disponibilidad** ante picos de tráfico.

4. **Argo Rollouts**
	- Permite hacer **despliegues escalonados** para verificar el correcto funcionamiento del sistema.  
	- Se han implementado **Canary Deployments** para minimizar riesgos.  
	- En caso de fallo, el sistema vuelve automáticamente a una **versión anterior**.
	
5. **NFS (Network File System)**  
	- Permite interactuar con el servidor de archivos para almacenar y recuperar imágenes utilizadas por el frontend.  
	- Facilita el **almacenamiento compartido** entre pods y garantiza que todos los entornos tengan acceso a los mismos recursos.

---
## 🛠️ Monitorización: ![Prometheus|38](https://skillicons.dev/icons?i=prometheus) Prometheus • ![Grafana|40](https://skillicons.dev/icons?i=grafana) Grafana

Utilizamos **Prometheus** para recopilar métricas y **Grafana** para visualizarlas de manera clara y en tiempo real.
### 1. Estadísticas de frontend
- Recogemos métricas usando **OpenTelemetry**.  
- Se configura un **collector** que recibe estas métricas y envía:
  - **Métricas a Prometheus**  
  - **Trazas a Tempo**
### 2. Estadísticas de backend
- Se recopilan mediante **Micrometer**, integrándose con nuestras aplicaciones para medir rendimiento y uso de recursos.
### 3. Estadísticas de base de datos
- El **operador de la base de datos** habilita monitorización automática sin necesidad de configuración adicional.

------
## 🛠️ Tecnologías utilizadas
- **Orquestación:** Docker, Kubernetes  
- **CI/CD:** GitHub Actions  
- **Monitorización:** Grafana, Prometheus  
- **Almacenamiento compartido:** NFS  
- **Sistema operativo base:** Proxmox

---
## 📝 Próximos pasos
- Completar los gráficos de monitorización en Grafana.  

## Repositorios adicionales
- Frontend: [https://github.com/PTIN-Projecte/frontend-web](https://github.com/PTIN-Projecte/frontend-web)  
- Backend: [https://github.com/PTIN-Projecte/backend](https://github.com/PTIN-Projecte/backend)
