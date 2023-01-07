variable "aws_profile" {
  type = string
  description = "Enter the Name for the AWS CLI Profile"
  default = "corra"
}

variable "aws_region" {
  type = string
  description = "Enter the Name for the AWS Region"
  default = "us-east-1"
}

variable "name" {
  type = string
  description = "Enter the Name for the server"
  default = "AMSPRJ-372-server-01"
}

variable "ami_id" {
  type = string
  description = "Enter the AMI ID to be used to create the server"
  default = "ami-08d090f841c8435e9"
}

variable "vpc_id" {
  type = string
  description = "Enter the VPC ID to be used to create the server"
  default = "vpc-f846ec9d"
}

variable "subnet_id" {
  type = string
  description = "Enter the subnet ID to be used to create the server"
  default = "subnet-d3f832a4"
}

variable "instance_type" {
  type = string
  description = "Enter the instance type be used to create the server"
  default = "m5.large"
}

variable "keyname" {
  type = string
  description = "Enter the SSH keypair Name to be used to create the server"
  default = "corrakochi"
}

variable "root_block_device" {
  type = list(map(string))
  description = "Enter the SSH keypair Name to be used to create the server"
  default = [
    {
        volume_type           = "gp2"
        volume_size           = 10
        delete_on_termination = "true"
        encypted              = "false"
    }
]
}
