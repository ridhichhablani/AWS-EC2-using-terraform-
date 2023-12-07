variable "access_key" {
        description = "Access key to AWS console"
}
variable "secret_key" {
        description = "Secret key to AWS console"
}


variable "instance_name" {
        description = "Name of the instance to be created"
        default = "devops-jenkins-machine"
}
variable "instance_type" {
        default = "m5.xlarge"
}

variable "subnet_id" {
        description = "The VPC subnet the instance(s) will be created in"
        default = "xxxxx"
}

variable "ami_id" {
        description = "The AMI to use"
        default = "xxxx"
}

variable "number_of_instances" {
        description = "number of instances to be created"
        default = 1
}


variable "ami_key_pair_name" {
        default = "test-jenkins"
}
