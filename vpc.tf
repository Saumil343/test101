module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  instance_tenancy   = var.instance_tenancy
  name               = var.vpc_name
  cidr               = var.vpc_cidr
  azs                = var.availability_zones
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = var.nat_gateway

  vpc_tags = merge(var.tags, {
    Name = "${local.vpc_name}"
  })

  public_subnet_tags = merge(var.tags, {
    Name = "${local.public_sub_name}"
  })
  private_subnet_tags = merge(var.tags, {
    Name = "${local.private_sub_name}"
  })
  public_route_table_tags = merge(var.tags, {
    Name = "${local.public_route_name}"
  })
  private_route_table_tags = merge(var.tags, {
    Name = "${local.private_route_name}"
  })
  igw_tags = merge(var.tags, {
    Name = "${local.igw_name}"
  })
}


locals {
  vpc_name           = "Saumil_shah_vpc"
  public_sub_name    = "Saumil_shah_public_subnet"
  private_sub_name   = "Saumil_shah_private_subnet"
  public_route_name  = "Saumil_shah_public_route"
  private_route_name = "Saumil_shah_private_route"
  igw_name           = "Saumil_shah_igw"
}


