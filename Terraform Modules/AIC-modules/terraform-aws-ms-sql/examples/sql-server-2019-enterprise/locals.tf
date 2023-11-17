locals {
  sql_version             = "2019"
  sql_edition             = "enterprise"
  sql_backups_s3_bucket   = "backup-${var.name}"
  create_s3_backup_bucket = true
  instance_type           = "m5.xlarge"
  env                     = "dev"
  maintenance_window      = "TUE_00"
}
