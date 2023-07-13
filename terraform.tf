# variable "amiid" {
#   default = "ami-006935d9a6773e4ec"
# }

# variable "subnet" {
#   default = "subnet-04f158e8258dc1aca"
# }

# variable "vpc_id" {
#   default = "vpc-0a01dc6234bcd92c8"
# }

variable "vpc_name" {
  type    = string
  default = "TASK_2_SaumilShah"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "key_name" {
  default = "terraform.tfstate"
}
variable "region" {
    type = string
  default = "us-east-1"
}
variable "versioning" {
  type    = bool
  default = true
}
variable "bucket_name" {
  type    = string
  default = "Saumil-shah-bucket-2-343"
}
variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}


variable "public_subnets" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "nat_gateway" {
  type    = bool
  default = false
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}

variable "tags" {
  default = {
    "Name"  = "Saumil-Shah"
    "Owner" = "Saumil.shah@intuitive.cloud"
  }
}