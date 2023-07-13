
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-minimal-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "jenkins-server"
  user_data = base64encode(file("${path.module}/jenkins.sh"))  
  ami                    = "ami-06a0cd9728546d178"
  instance_type          = "t2.micro"
  # subnet_id              = module.vpc_
  subnet_id     = module.vpc.public_subnets[1]
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.allow_jenkins.id]

  tags = {
    Name = "jenkins-server"
  }
}