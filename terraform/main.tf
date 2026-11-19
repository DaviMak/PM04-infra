resource "aws_key_pair" "deploy" {
  key_name   = "${var.environment}-deploy"
  public_key = var.public_key
}

resource "aws_instance" "vm" {
  for_each      = toset(["app", "db"])
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deploy.key_name
  user_data     = file("${path.module}/user_data.sh")

  tags = {
    Name        = "${var.instance_name}-${each.key}"
    Role        = each.key
    Environment = var.environment
  }
}