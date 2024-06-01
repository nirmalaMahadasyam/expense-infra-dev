module "db"{    
     source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment_name = var.environment_name
    common_tags = var.common_tags
     sg_description = "SG for DB mysql instances"
     vpc_id = data.aws_ssm_parameter.vpc_id.value
     sg_name = "db"
}

module "backend"{    
     source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment_name = var.environment_name
    common_tags = var.common_tags
     sg_description = "SG for backend instances"
     vpc_id = data.aws_ssm_parameter.vpc_id.value
     sg_name = "backend"
}

module "frontend"{    
     source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment_name = var.environment_name
    common_tags = var.common_tags
     sg_description = "SG for frontend instances"
     vpc_id = data.aws_ssm_parameter.vpc_id.value
     sg_name = "frontend"
}
# module for bastion
module "bastion"{    
     source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment_name = var.environment_name
    common_tags = var.common_tags
     sg_description = "SG for bastion instances"
     vpc_id = data.aws_ssm_parameter.vpc_id.value
     sg_name = "bastion"
}
# module for app-alb
module "app_alb"{    
     source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment_name = var.environment_name
    common_tags = var.common_tags
     sg_description = "SG for app alb instances"
     vpc_id = data.aws_ssm_parameter.vpc_id.value
     sg_name = "app-alb"
}
# module for vpn
module "vpn"{    
     source = "../../terraform-aws-securitygroup"
    project_name = var.project_name
    environment_name = var.environment_name
    common_tags = var.common_tags
     sg_description = "SG for vpn instances"
     vpc_id = data.aws_ssm_parameter.vpc_id.value
     sg_name = "vpn"  
    ingress_rules = var.vpn_sg_rules  
     
}


# db accepted to connected from backend
resource "aws_security_group_rule" "db_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  
  source_security_group_id = module.backend.sg_id # source is where you getting traffic(backend)
  security_group_id = module.db.sg_id # whcih security group we connected(db)
}
##################################################################
#db accepted to connect from bastion (follow sg-rules.yaml)

resource "aws_security_group_rule" "db_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  
  source_security_group_id = module.bastion.sg_id # source is where you getting traffic(backend)
  security_group_id = module.db.sg_id # whcih security group we connected(db)
}

#######################################################################

# backend accepted to conncted from app_alb
resource "aws_security_group_rule" "backend_app_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  
  source_security_group_id = module.app_alb.sg_id # source is where you getting traffic(frontend)
  security_group_id = module.backend.sg_id # whcih security group we connected(backend)
}

# backend accepted to conncted from vpn(ssh)
resource "aws_security_group_rule" "backend_vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  
  source_security_group_id = module.vpn.sg_id # source is where you getting traffic(frontend)
  security_group_id = module.backend.sg_id # whcih security group we connected(backend)
}
# backend accepted to conncted from vpn(http)
resource "aws_security_group_rule" "backend_vpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  
  source_security_group_id = module.vpn.sg_id # source is where you getting traffic(frontend)
  security_group_id = module.backend.sg_id # whcih security group we connected(backend)
}

#######################################################################

# backend accepted to conncted from bastion
resource "aws_security_group_rule" "backend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  
  source_security_group_id = module.bastion.sg_id # source is where you getting traffic(frontend)
  security_group_id = module.backend.sg_id # whcih security group we connected(backend)
}


###############################################################################

# frontend accepted to conncted from public(internet)
resource "aws_security_group_rule" "frontend_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  #source_security_group_id = module.frontend.sg_id # source is where you getting traffic(public)
  security_group_id = module.frontend.sg_id # whcih security group we connected(frontend)
}

###############################################################################

# frontend accepted to conncted from bastion
resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  source_security_group_id = module.bastion.sg_id # source is where you getting traffic(bastion)
  security_group_id = module.frontend.sg_id # whcih security group we connected(frontend)
  }

 
###############################################################################
# bastion accepted to conncted from public
resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

