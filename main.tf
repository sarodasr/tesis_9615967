
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
  }
}

# Configuración de proveedor específico, que es AWS
provider "aws" {
  access_key = "AKIA45UF4WHJ5DCOFBFM"
  secret_key = "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"
  region     = "us-east-1"
}

# Instancia general
resource "aws_instance" "tesis_capitulo03" {
  # Microsoft Windows Server 2022 Base
  ami = "ami-0d86c69530d0a048e"
  # Tipo de instancia
  instance_type = "t2.micro"
  # Etiquetas relacionadas
  tags = {
    Name = "Instancia base"
  }

  vpc_security_group_ids = [aws_security_group.capitulo03-3_2_1-02.id]
}

#Bucket de desarrollo
resource "aws_s3_bucket" "bucket-general-tesis" {
  bucket = "bucket-general-tesis"

  tags = {
    Environment = "Desarrollo"
    Department  = "Ingeniería en Ciencias y Sistemas"
  }
}