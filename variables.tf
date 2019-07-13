variable "project" {
  default = "test"
}

variable "private_key" {
  default = "./secrets/test_deploy_key"
}

variable "key_name" {
  description = "Desired name of AWS key pair"
  default     = "app_deployer_key"
}

variable "public_key_file" {
  default = "./secrets/test_deploy_key.pub"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-west-2"
}

# Ubuntu Precise 16.04 LTS (x64)
variable "aws_amis" {
  default = {
    us-east-1  = "ami-f4cc1de2"
    us-east-2  = "ami-fcc19b99"
    us-west-1  = "ami-16efb076"
    us-west-2  = "ami-a58d0dc5"
    ap-south-1 = "ami-04125d804acca5692"
  }
}

variable "nat_amis" {
  default = {
    # us-east-1  = "ami-f4cc1de2"
    # us-east-2  = "ami-fcc19b99"
    # us-west-1  = "ami-16efb076"
    us-west-2 = "ami-0032ea5ae08aa27a2"

    # ap-south-1 = "ami-04125d804acca5692"
  }
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "private_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "public_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ip_list" {
  description = "IP Whitelist."
  default     = ["0.0.0.0/0"]
}

#  Bastian configs
variable "bastian_instance_type" {
  default = "t2.nano"
}

variable "bastian_public_key_file" {
  default = "~/.ssh/id_rsa.pub"
}

variable "rds_username" {
  default = "dbmaster"
}

variable "rds_password" {
  default = "TQEyUkNmB_3hfdnRPE4ETje6onvrG8"
}

variable "RDS_DB_ALLOCATED_STORAGE" {
  default = "8"
}

variable "ENGINE_DBTYPE" {
  default = "mysql"
}

variable "ENGINE_VERSION" {
  default = "5.7.21"
}

variable "DB_INSTANCE_TYPE" {
  default = "db.t2.micro"
}

variable "RDS_STORAGE_TYPE" {
  default = "gp2"
}

variable "rds_env_name" {
  default = "dqs"
}
