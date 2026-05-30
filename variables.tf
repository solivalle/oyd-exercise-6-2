variable "region" {
  type        = string
  description = "AWS region."
  default     = "us-west-2"
}


variable "vpc_name" {
  type        = string
  description = "Name tag applied to the VPC and subnets — used by data sources in the root workspace."
  default     = "mediastream-vpc"
}


variable "instance_name" {
  type        = string
  description = "Name tag applied to the EC2 instance — used by the data source in the root workspace."
  default     = "mediastream-api"
}

variable listener_port {
  type        = number
  description = "Port on which the API server listens."
  default     = 80
}

variable environment {
  type        = string
  description = "Deployment environment (e.g., dev, staging, prod)."
  default     = "dev"
}