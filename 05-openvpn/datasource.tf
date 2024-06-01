# for bastion_sg_id (quering)
data "aws_ssm_parameter" "vpn_sg_id" {
  name = "/${var.project_name}/${var.environment_name}/vpn_sg_id"
}
# for ansible_sg_id(quering) public_subnet_id
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}/${var.environment_name}/public_subnet_ids"
}

# for ami id (terraform(data))

data "aws_ami" "ami_info" {

    most_recent = true
    owners = ["679593333241"]

    filter {
        name   = "name"
        values = ["OpenVPN Access Server Community Image-fe8020db-*"]
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

