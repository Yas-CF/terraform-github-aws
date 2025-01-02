resource "aws_security_group" "api_sg" {
  name        = "api-server-sg"
  description = "Security group for API server"
  vpc_id      = var.vpc_id

  # Regla para permitir tráfico HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regla para permitir tráfico HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regla para permitir SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_access_cidr]
  }
  # Permitir tráfico al puerto de la aplicación Node.js
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Regla de salida por defecto (permitir todo el tráfico saliente)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "API Security Group"
  }
}

resource "aws_instance" "api_server" {
  ami           = var.ami_id             # AMI de Ubuntu
  instance_type = var.instance_type      # Tipo de instancia
  subnet_id     = var.subnet_id          # Subnet donde se lanza la instancia
  key_name      = "rsa-Cursodevops"      # Nombre de la clave SSH
  vpc_security_group_ids = [aws_security_group.api_sg.id] # Grupo de seguridad

  user_data = <<-EOF
  #!/bin/bash
  # Actualizar el sistema
  sudo apt-get update -y
  sudo apt-get upgrade -y

  # Instalar Node.js y NPM (última versión LTS)
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  sudo apt-get install -y nodejs

  # Crear el directorio para la aplicación
  mkdir -p /var/www/myapp
  cd /var/www/myapp

  # Crear un servidor básico con Express.js
  cat << 'APP' > app.js
  const express = require('express');
  const app = express();

  app.get('/', (req, res) => {
    res.send('¡Bienvenido a mi servidor Node.js en Ubuntu!');
  });

  const PORT = 3000;
  app.listen(PORT, () => {
    console.log(\`Servidor corriendo en http://localhost:${PORT}\`);
  });
  APP

  # Inicializar NPM y configurar dependencias
  npm init -y
  npm install express

  # Instalar PM2 para manejar procesos
  sudo npm install -g pm2
  pm2 start app.js
  pm2 startup
  pm2 save

  # Instalar Amazon CloudWatch Agent
  sudo apt-get install -y wget
  wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
  sudo dpkg -i amazon-cloudwatch-agent.deb

  # Configurar CloudWatch Agent
  cat << 'CWAGENT' > /opt/aws/amazon-cloudwatch-agent/bin/config.json
  {
      "metrics": {
          "append_dimensions": {
              "InstanceId": "${aws:InstanceId}"
          },
          "metrics_collected": {
              "cpu": {
                  "measurement": ["cpu_usage_idle", "cpu_usage_iowait", "cpu_usage_user", "cpu_usage_system"],
                  "metrics_collection_interval": 60,
                  "resources": ["*"]
              },
              "disk": {
                  "measurement": ["used_percent"],
                  "metrics_collection_interval": 60,
                  "resources": ["/"]
              },
              "mem": {
                  "measurement": ["used_percent"],
                  "metrics_collection_interval": 60
              }
          }
      }
  }
  CWAGENT

  # Iniciar el agente de CloudWatch
  sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s
  EOF

  tags = {
    Name = "API Server with CloudWatch"
  }
}
