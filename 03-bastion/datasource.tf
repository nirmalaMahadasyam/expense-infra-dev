# for bastion_sg_id (quering)
data "aws_ssm_parameter" "bastion_sg_id" {
  name = "/${var.project_name}/${var.environment_name}/bastion_sg_id"
}
# for ansible_sg_id(quering) public_subnet_id
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment_name}/public_subnet_ids"
}

# for ami id (terraform(data))

data "aws_ami" "ami_info" {

    most_recent = true
    owners = ["973714476881"]

    filter {
        name   = "name"
        values = ["RHEL-9-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

