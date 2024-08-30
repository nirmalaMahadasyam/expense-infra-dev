data "aws_ssm_parameter" "db_sg_id" {
  name = "/${var.project_name}/${var.environment_name}/db_sg_id"
}

data "aws_ssm_parameter" "db_subnet_group_name" {
  name = "/${var.project_name}/${var.environment_name}/db_subnet_group_name"
}