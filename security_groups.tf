# Ejemplo No. 1 - Crear grupo simple que permita 
# acceso SSH (puerto 22) desde cualquier IP
resource "aws_security_group" "capitulo03-3_2_1-01" {
  name        = "cap03-3_2_1-ej01"
  description = "Acceso SSH publico"
  ingress {
    from_port   = 22            #Puerto SSH
    to_port     = 22            #Puerto SSH
    protocol    = "tcp"         #Protocolo tcp
    cidr_blocks = ["0.0.0.0/0"] #Cualquier IP
  }
}

resource "aws_security_group" "capitulo03-3_2_1-02" {
  name        = "cap03-3_2_1-ej02"
  description = "Acceso SSH/HTTPS restringido"

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    create = "10m"
    delete = "20m"
  }

  tags = {
    Name        = "Ejemplo Capítulo 3. Sección 3.2.1"
    Environment = "Desarrollo"                        #Tag personalizado
    Department  = "Ingeniería en Ciencias y Sistemas" #Tag personalizado
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.0.2.0/24"] # Permitir acceso SSH desde una IP específica
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["203.0.113.0/24", "198.51.100.0/24"] # Permitir acceso HTTPS desde un bloque de IP específico
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

