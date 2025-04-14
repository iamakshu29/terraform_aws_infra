resource "aws_key_pair" "terraform_key_pair" {
  key_name   = "terraform_key_pair"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICOkhiO4Xh0JUYvwsYlw9Sm8Dpk8f9ULgPE4IuQsGd9T verma@Akshat"
}