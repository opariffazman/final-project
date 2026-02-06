data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

module "private_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.2.0"

  for_each = toset(["1", "2"])

  name = "private-instance-${each.key}"

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  monitoring             = false
  subnet_id              = module.vpc.private_subnets[0]
  create_security_group  = false
  vpc_security_group_ids = [module.private_security_group.security_group_id]

  tags = {
    Terraform   = "true"
    Environment = "bootcamp"
  }
}

module "public_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.2.0"

  name = "public-instance"

  ami                    = data.aws_ami.ubuntu.id
  create_eip             = true
  instance_type          = "t3.micro"
  monitoring             = false
  subnet_id              = module.vpc.public_subnets[0]
  create_security_group  = false
  vpc_security_group_ids = [module.ssh_security_group.security_group_id, module.prometheus_node_exporter_security_group.security_group_id]

  tags = {
    Terraform   = "true"
    Environment = "bootcamp"
  }
}
