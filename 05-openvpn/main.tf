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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDa+LyrxJG9NaeG9TDk+IcvnWWJ6xy5plZJTMRg/Y6CWeL7wK9ecbqLZH1OqEkVKhX5hZOsv+y80qg0h6pZQHX6JqdC+cZqzIvxul4KR/LHv2RcsjrEyI/gE+fRGVStDASXz3zWwiiaQ+hYV3e6PG+gEe1faRSk40abJpAoNnnNzIcJutM2QDfcAVXXgGD/Ozq4/DAPZ/x4+eUEYpNZ0M+1Y3TFhz416MdrSVmIWnH6U31PojHJEhSHyhazqdIokXuAB1FZ+rm0PpKJqxPVmorEopnPeSGPQ1DVFF/HQifCbvcrA4ipw4IR7lw70A95G06Gg5abc1bjt2/I1FvdI/jSt3rcLr8oTyaIoNI0tvjQIxIzve74mqd2AxtkqrYyYiZYVNOvNona5Q3pAoCMhU9g9Y58HGQwAZrDW9luYQQu/XJfqGSvIMSGjZtg/PUjvaXA20N07A1olSJ+Ol8fGqjqH2XuIDP3LT5tcftU87f7+S9dF/KQlhZCGWIfnovkL+qOW1sHDFZeb9p4djwqgsKN3Eo2TFlOKp/ocBRqPTPl+wKAD2VN/Um5EsWUHB5VXAzsJnUA0LTdFJY0psOrBHPSbw1CvNuUVCNxMFX1qGmNPxumu/16+zrIMwIi/mmLep8XccgiwKDHocxi/FIFq0CPzVHvyTXRxGgUFaGn9ZaLuw== DELL@DESKTOP-5CKL54M"
  # public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHUifmEurfyvLWEVmj5WgVYbJxOYVS0i65MJvUoOQfKw DELL@DESKTOP-5CKL54M"
   # public_key = file("~/.ssh/openvpn.pub")
  # ~ means windows home
}
