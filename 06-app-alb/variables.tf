variable "project_name"{
    type = string
    default = "expense"

}
variable "environment_name" {
  type = string
  default = "dev"
}
variable "common_tags" {
    type = map
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = true  
        component = "app-alb"             # add the component # usage: help for billing purpose querrying this lb.
    }
  
}
################################################
variable "zone_name" {
  default = "nirmaladevops.cloud"
}