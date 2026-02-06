module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  name = "my-vpc"
  cidr = "10.0.0.0/24"

  azs             = ["ap-southeast-1a"]
  private_subnets = ["10.0.0.0/25"]
  public_subnets  = ["10.0.0.128/25"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "bootcamp"
  }
}
