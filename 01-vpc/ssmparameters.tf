resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}/${var.environment_name}/vpc_id"
  type  = "String" # this is compulsary... it is aws notation
  value = module.vpc.vpc_id # vpc_id ---> module developed code it will compulsary to declared in output.tf(terraform-aws-vpc) file then only we get the value
}

############# for 03-bastion required
resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project_name}/${var.environment_name}/public_subnet_ids"
  type  = "StringList"
  value = join("," ,module.vpc.public_subnet_ids) # converting list to string list
}

#["id1","id2"] terraform format
# id1, id2 -> AWS SSM format
resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project_name}/${var.environment_name}/private_subnet_ids"
  type  = "StringList"
  value = join(",",module.vpc.private_subnet_ids) # converting list to string list
}

resource "aws_ssm_parameter" "db_subnet_group_name" {
  name  = "/${var.project_name}/${var.environment_name}/db_subnet_group_name"
  type  = "String"
  value = module.vpc.database_subnet_group_name
}
# publicsubnetid's datatype---List
#type= stringList......# ["id1","id2","id3"] .....terraform format
#aws format----[id1,id2,id3] .... join(used to convert list to stringlist)
# private-subnet-id to push in ssm parameters store
