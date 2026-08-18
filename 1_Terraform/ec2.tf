# key pair
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("keys/terra-key-ec2.pub")

}
# vpc 
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# resource "aws_vpc" "mainvpc" {
#   cidr_block = "10.1.0.0/16"
# }

# security groups
resource "aws_default_security_group" "default" {
  vpc_id = aws_default_vpc.default.id

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#& security group
# ec2 instance

resource "aws_instance" "my_ec2_instance" {
#   count = 2
  for_each = tomap({
    instance1 = "instance1"
    instance2 = "instance2"
  })
  depends_on = [aws_key_pair.deployer, aws_default_security_group.default]
  ami                    = "ami-0b6d9d3d33ba97d99"
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_default_security_group.default.id]
  user_data              = file("scripts/install_nginx.sh")
  # ========================================
  # Root EBS Volume
  # ========================================

  root_block_device {
    volume_size           = 20 
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true

  }

  tags = {
    Name = "Terraform-EC2"
  }
}