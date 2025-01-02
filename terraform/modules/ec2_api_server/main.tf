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
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = "rsa-Cursodevops"
  vpc_security_group_ids = [aws_security_group.api_sg.id]

  user_data = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y yum-utils
  sudo yum install -y amazon-cloudwatch-agent
  sudo cp /tmp/cloudwatch-config.json /opt/aws/amazon-cloudwatch-agent/bin/config.json
  sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s

  EOF

  tags = {
    Name = "API Server Instance"
  }
}