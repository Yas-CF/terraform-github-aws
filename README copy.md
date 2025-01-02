# Prueba Cloud DevOps Automation

## Descripción del Proyecto
Este proyecto está diseñado para optimizar los procesos y aplicaciones en la nube mediante la automatización y gestión de una infraestructura tecnológica avanzada. Se enfoca en establecer un sistema integral de monitoreo en tiempo real para infraestructuras alojadas en AWS. Utilizando Terraform para la gestión eficaz de recursos y GitHub Actions para la automatización del flujo de trabajo, el proyecto busca mejorar la visibilidad operativa y garantizar la conformidad con los estándares de seguridad y rendimiento.

## Estructura del Repositorio
El repositorio está organizado en varias carpetas que contienen los scripts de Terraform, las configuraciones de Docker, y los flujos de trabajo de GitHub Actions, así como el código fuente de la aplicación.

. |-- .github/ # Configuraciones de GitHub Actions | |-- workflows/ # Definiciones de workflows | |-- ci.yml # Workflow de Integración Continua | |-- cd.yml # Workflow de Despliegue Continuo | |-- security.yml # Workflow para escaneos de seguridad | |-- terraform/ # Archivos de configuración de Terraform | |-- main.tf # Configuración principal | |-- variables.tf # Definición de variables | |-- outputs.tf # Salidas de configuraciones | |-- backend.tf # Configuración del backend de Terraform | |-- vpc.tf # Configuración de VPC | |-- ec2.tf # Configuración de instancias EC2 | |-- lambda.tf # Configuración de AWS Lambda | |-- docker/ # Dockerfiles y configuraciones relacionadas | |-- Dockerfile # Dockerfile para la construcción de la imagen | |-- .dockerignore # Lista de archivos a ignorar en la construcción | |-- src/ # Código fuente de la aplicación | |-- app/ | |-- index.html # Página principal | |-- style.css # Hojas de estilo | |-- script.js # Scripts JavaScript | |-- scripts/ # Scripts para despliegue y configuración | |-- deploy.sh # Script para despliegue | |-- setup.sh # Script de configuración inicial | |-- README.md # Este archivo |-- .gitignore # Archivo para ignorar archivos en git

## Tecnologías Utilizadas
- **AWS** (EC2, VPC, Lambda, CloudWatch)
- **Terraform** para la gestión de infraestructura como código
- **Docker** para la contenerización de la aplicación
- **GitHub Actions** para la automatización de CI/CD y escaneos de seguridad

## Autores
- **Yasna Candia** - Trabajo Inicial - [Yas-CF](https://github.com/Yas-CF)
