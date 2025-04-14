# Create the bucket
resource "aws_s3_bucket" "tf_state" {
  bucket = "rev-terraform-state-akshat" # Must be globally unique
  force_destroy = true

  lifecycle {
    prevent_destroy = false
  }
}

# Enable versioning separately
resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}
