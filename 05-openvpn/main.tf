module "vpn" {
  source  = "terraform-aws-modules/ec2-instance/aws"
key_name = aws_key_pair.vpn.key_name
  name = "${var.project_name}-${var.environment_name}-vpn"

  instance_type          = "t3.micro"
  
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  subnet_id              = local.public_subnet_id
  
  
  ami = data.aws_ami.ami_info.id

   tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment_name}-vpn"
    }
  )
}
resource "aws_key_pair" "vpn" {
  key_name   = "openvpn"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDmWaESdFSV2fgKyv38cve3U4/F9yK7hZ/urqGcpzAO9 DELL@DESKTOP-5CKL54M"
  # public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHUifmEurfyvLWEVmj5WgVYbJxOYVS0i65MJvUoOQfKw DELL@DESKTOP-5CKL54M"
   # public_key = file("~/.ssh/openvpn.pub")
  # ~ means windows home
}
