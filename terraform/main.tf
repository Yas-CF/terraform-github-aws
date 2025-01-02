provider "aws" {
  region  = "us-east-1" 
}

# Módulo de VPC
module "vpc" {
  source    = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

# Módulo de Internet Gateway
module "gateway" {
  source  = "./modules/gateway"
  vpc_id  = module.vpc.vpc_id
}

# Módulo de Subredes
module "subnets" {
  source              = "./modules/subnets"
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}

# Módulo de Tabla de Rutas
module "route_table" {
  source              = "./modules/route_table"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.gateway.gateway_id
  public_subnet_id    = module.subnets.public_subnet_id
}

module "ec2_api_server" {
  source         = "./modules/ec2_api_server"
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  instance_name   = var.instance_name
  subnet_id      = module.subnets.public_subnet_id
  vpc_id         = module.vpc.vpc_id
  ssh_access_cidr = var.ssh_access_cidr
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
  file_key    = var.file_key
  file_path   = var.file_path
}

module "sqs" {
  source      = "./modules/sqs"
  environment = var.environment
}

module "sns" {
  source = "./modules/sns"
  alert_email = var.alert_email
  environment = var.environment
}

module "lambda" {
  source          = "./modules/lambda"
  function_name   = "MyLambdaFunction"
  bucket_name     = module.s3.bucket_name
  file_key        = module.s3.object_key
  queue_arn       = module.sqs.queue_arn
  queue_url       = module.sqs.queue_url
  topic_arn       = module.sns.topic_arn
}

module "cloudwatch" {
  source          = "./modules/cloudwatch"
  instance_name   = var.instance_name
  cpu_threshold   = var.cpu_threshold
  disk_threshold  = var.disk_threshold
  memory_threshold = var.memory_threshold
  topic_arn   = module.sns.sns_topic_arn
}