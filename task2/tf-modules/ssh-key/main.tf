resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = var.ssh_public_key

  tags = {
    name = var.key_name
  }
}