#resource "aws_securityhub_account" "capitulo03-securityhub-general" {
#  enable_default_standards = true
#  auto_enable_controls     = true
#}


#resource "aws_securityhub_standards_control" "capitulo03-control" {
#  standards_control_arn = "arn:aws:securityhub:us-east-1:888265290195:ruleset/cis-aws-foundations-benchmark/v/1.2.0"
#  control_status        = "ENABLED"
#}

#resource "aws_guardduty_detector" "capitulo03-detector-ejemplo" {
#  enable = true
#  finding_publishing_frequency = "SIX_HOURS"
#  datasources {
#    s3_logs {
#      enable = true
#    }
#    kubernetes {
#      audit_logs {
#        enable = false
#      }
#    }
#    malware_protection {
#      scan_ec2_instance_with_findings {
#        ebs_volumes {
#          enable = true
#        }
#      }
#    }
#  }
#}

resource "aws_guardduty_filter" "ssh_bruteforce" {
  name        = "ssh-bruteforce-inbound"
  description = "Suprime intentos de ataques de fuerza bruta por SSH"
  action      = "ARCHIVE"
  detector_id = "82c46a78d1e04a431ed619ae11e12229"
  rank        = 1

  finding_criteria {
    criterion {
     field  = "type"
      equals = ["UnauthorizedAccess:EC2/SSHBruteForce"]
    }
    criterion {
      field  = "service.resourceRole"
      equals = ["TARGET"]
    }
 }
}

resource "aws_s3_bucket_ownership_controls" "capitulo03-ownership-controls" {
  bucket = aws_s3_bucket.bucket-general-tesis.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "capitulo03-public-access-block" {
  bucket = aws_s3_bucket.bucket-general-tesis.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "capitulo03-bucket-acl-general" {
  depends_on = [
    aws_s3_bucket_ownership_controls.capitulo03-ownership-controls,
    aws_s3_bucket_public_access_block.capitulo03-public-access-block
  ]

  bucket = aws_s3_bucket.bucket-general-tesis.id
  acl    = "public-read"
}

resource "aws_s3_object" "MyIPSet" {
  acl     = "public-read"
  content = "10.0.0.0/8\n"
  bucket  = aws_s3_bucket.bucket-general-tesis.id
  key     = "my-ipset"
}

resource "aws_guardduty_ipset" "capitulo03-ipset-general" {
  activate    = true
  detector_id = "82c46a78d1e04a431ed619ae11e12229"
  format      = "TXT"
  location    = "s3://${aws_s3_object.MyIPSet.bucket}/${aws_s3_object.MyIPSet.key}"
  name        = "MyIPSet"
}