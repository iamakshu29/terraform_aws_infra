resource "aws_key_pair" "elb_key" {
  key_name   = "elb_key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGYVZG20rhTNQHb7454bDc8vUFTC+Kh4Akkhvmnpjvt0 verma@Akshat"
}