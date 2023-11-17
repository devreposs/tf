// S3 Bucket for DB Backups
resource "aws_s3_bucket" "s3_backup_bucket" {
  // Bastion bucket containing keys and scripts
  count  = var.create_s3_backup_bucket ? 1 : 0
  bucket = "${lower(var.name)}-${lower(var.env)}-${random_id.id_key.hex}"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }

  tags = var.tags
}

// Allow EC2 AssumeRole for DB Backups to S3
data "aws_iam_policy_document" "ec2_assume_role" {
  // Create policy document allowing ec2 assumerole access
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

// Allow access to S3 Bucket for ec2 Backup
data "aws_iam_policy_document" "s3_backup_bucket_access" {
  count = var.create_s3_backup_bucket ? 1 : 0

  // Policy Document allowing read access to S3 ec2 bucket for backup
  statement {
    sid    = "Allowec2Bucket-List"
    effect = "Allow"

    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
    ]

    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.ec2_access.arn]
    }

    resources = [
      aws_s3_bucket.s3_backup_bucket[0].arn,
    ]
  }

  // Policy Document allowing put access to S3 bucket for backup
  statement {
    sid    = "Allowec2BucketPut"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload",
    ]

    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.default.arn]
    }

    resources = [
      "${aws_s3_bucket.s3_backup_bucket[0].arn}/*",
    ]
  }
}

// Bind access to role
resource "aws_iam_role" "ec2_access" {
  // IAM Role for Instance
  name_prefix        = "${var.name}-"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
  tags               = var.tags
}

// Bind access to S3 bucket
resource "aws_s3_bucket_policy" "s3_backup_bucket_access" {
  // Policy granting access to bucket based on policy document
  count  = var.create_s3_backup_bucket ? 1 : 0
  bucket = aws_s3_bucket.s3_backup_bucket[0].bucket
  policy = data.aws_iam_policy_document.s3_backup_bucket_access[0].json
}
