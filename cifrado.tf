resource "aws_kms_key" "capitulo03-3_2_3-llave01" {
  description             = "Primera llave configurada por medio de Terraform"
  deletion_window_in_days = 30
  policy                  = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Habilita al usuario de la tesis",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::888265290195:root",
          "arn:aws:iam::888265290195:user/user_tesis",
          "arn:aws:iam::888265290195:user/user-tesis-general"
        ]
      },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
EOF

  tags = {
    Environment = "Desarrollo"
    Application = "Tesis01"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "capitulo03-bucket-config-cifrado" {
  bucket = aws_s3_bucket.bucket-general-tesis.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.capitulo03-3_2_3-llave01.id
      sse_algorithm     = "aws:kms"
    }
  }
}
