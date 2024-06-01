#db
resource "aws_ssm_parameter" "db_sg_id" {
  name  = "/${var.project_name}/${var.environment_name}/db_sg_id"
  type  = "String" # this is compulsary... it is aws notation
  value = module.db.sg_id # vpc_id ---> module developed code it will compulsary to declared in output.tf(terraform-aws-securitygroup) file then only we get the value
}
# backend
resource "aws_ssm_parameter" "backend_sg_id" {
  name  = "/${var.project_name}/${var.environment_name}/backend_sg_id"
  type  = "String" # this is compulsary... it is aws notation
  value = module.backend.sg_id # vpc_id ---> module developed code it will compulsary to declared in output.tf(terraform-aws-securitygroup) file then only we get the value
}
#frontend
resource "aws_ssm_parameter" "frontend_sg_id" {
  name  = "/${var.project_name}/${var.environment_name}/frontend_sg_id"
  type  = "String" # this is compulsary... it is aws notation
  value = module.frontend.sg_id # vpc_id ---> module developed code it will compulsary to declared in output.tf(terraform-aws-securitygroup) file then only we get the value
}
#################################### for 03-bastion
#bastion
resource "aws_ssm_parameter" "bastion_sg_id" {
  name  = "/${var.project_name}/${var.environment_name}/bastion_sg_id"
  type  = "String" # this is compulsary... it is aws notation
  value = module.bastion.sg_id # vpc_id ---> module developed code it will compulsary to declared in output.tf(terraform-aws-securitygroup) file then only we get the value
}
#vpn
resource "aws_ssm_parameter" "vpn_sg_id" {
  name  = "/${var.project_name}/${var.environment_name}/vpn_sg_id"
  type  = "String" # this is compulsary... it is aws notation
  value = module.vpn.sg_id # vpc_id ---> module developed code it will compulsary to declared in output.tf(terraform-aws-securitygroup) file then only we get the value
}

#app_alb
resource "aws_ssm_parameter" "app_alb_sg_id" {
  name  = "/${var.project_name}/${var.environment_name}/app_alb_sg_id"
  type  = "String" # this is compulsary... it is aws notation
  value = module.app_alb.sg_id # vpc_id ---> module developed code it will compulsary to declared in output.tf(terraform-aws-securitygroup) file then only we get the value
}

