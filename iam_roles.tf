#Rol de ejemplo
resource "aws_iam_role" "capitulo03-3_2_2-rol-01" {
  name        = "rol-ejemplo"
  path        = "/ejemplos/"
  description = "Ejemplo de roles en IAM"

  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          "Service" : "ec2.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Environment = "Desarrollo"
    Department  = "Ingeniería en Ciencias y Sistemas"
  }

  permissions_boundary = aws_iam_policy.capitulo03-3_2_2-politica-01.arn
}

data "aws_iam_policy_document" "cfgPolitica" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:GetObject"
    ]
    resources = [
      aws_s3_bucket.bucket-general-tesis.arn,
      "${aws_s3_bucket.bucket-general-tesis.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "capitulo03-3_2_2-politica-01" {
  name        = "politica-ejemplo"
  path        = "/ejemplos/"
  description = "Ejemplo de políticas en IAM"

  policy = data.aws_iam_policy_document.cfgPolitica.json
}

resource "aws_iam_policy_attachment" "capitulo03-3_2_2-politica02a" {
  name = "capitulo03-3_2_2-politica-adjunta"

  policy_arn = "arn:aws:iam::888265290195:policy/capitulo03-3_2_2-politica02"

  users = ["user_tesis"]

  groups = ["administrators"]

  roles = ["rol-s3"]

}