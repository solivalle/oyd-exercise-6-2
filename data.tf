# Data sources for Terraform configuration

# Look up the VPC by Name tag
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

# Look up public subnets in the VPC by Tier tag
data "aws_subnets" "public" {
  filter {
    name   = "tag:Tier"
    values = ["public"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

# Look up the running EC2 instance by Name tag
data "aws_instance" "api" {
  filter {
    name   = "tag:Name"
    values = [var.instance_name]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}
