# Vars
variable "s3_artifacts_bucket_name"{}

resource "aws_s3_bucket" "artifacts_bucket"{
    bucket = var.s3_artifacts_bucket_name

    tags = {
        description = "s3 bucket to store pipeline artifacts"
    }
}

resource "aws_s3_bucket_acl" "bucket_acl"{
    bucket = aws_s3_bucket.artifacts_bucket.id
    acl = "private"
}