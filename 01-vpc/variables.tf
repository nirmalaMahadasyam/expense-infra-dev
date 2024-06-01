variable "project_name" {
    type = string
    default = "expense"
  
}
########## for ssm parameter requirement
variable "environment_name" {
    type = string
    default = "dev"
  
}
###############

variable "common_tags" {
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = "true" 

    }
  
}

# public subnet

variable "public_subnet_cidr" {
    default = ["10.0.1.0/24","10.0.2.0/24"]
  
}

#private subnet
variable "private_subnet_cidr" {
    default = ["10.0.11.0/24","10.0.12.0/24"]
  
}
# database subnet
variable "database_subnet_cidr" {
     default = ["10.0.21.0/24","10.0.22.0/24"]
  
  
}
# peering 
variable "is_peering_required" {
    default = true
  
}

