module "prometheus_node_exporter_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"

  name        = "public_security_group"
  description = "Security group for prometheus node exporter in webserver"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["prometheus-node-exporter-http-tcp"]
  egress_rules        = ["all-all"]
}

module "ssh_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"

  name        = "ssh_security_group"
  description = "Security group for ssh"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["10.0.0.0/25"]
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]
}

module "private_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"

  name        = "private_security_group"
  description = "Security group for private EC2"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]
}
