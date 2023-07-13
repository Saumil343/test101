resource "aws_security_group" "allow_jenkins" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  # vpc_id      = module.vpc.default_vpc_id
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}