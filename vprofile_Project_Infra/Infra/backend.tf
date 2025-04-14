terraform {
  backend "s3" {
    bucket         = "rev-terraform-state-akshat"    # S3 bucket name
    key            = "env/dev/terraform.tfstate"     # Path inside bucket
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"                # Your dynamodb table name
    encrypt        = true
  }
}
