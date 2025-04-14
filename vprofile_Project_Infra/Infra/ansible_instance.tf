# resource "aws_instance" "ansible_instance" {
#   ami               = var.amiID
#   instance_type     = "t2.micro"
#   key_name          = aws_key_pair.terr_rev.key_name
#   security_groups   = [aws_security_group.memcache.name]
#   availability_zone = "us-east-1a"

#   tags = {
#     Name = "ansible_instance"
#     Type = "controller"
#     Environment = "dev"
#     ManagedBy= "Terraform"
#   }
# }
