# To get the AMI ID
data "aws_ami" "amiID" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}


output "ami-0f9de6e2d2f067fca" {
  description = "AMI ID of ubuntu instance"
  value       = data.aws_ami.amiID.id
}
