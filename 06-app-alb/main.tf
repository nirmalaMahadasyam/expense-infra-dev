resource "aws_lb" "app_alb" {  ## google: terraform aws alb
  name               = "${var.project_name}-${var.environment_name}-app-alb" # follow our naming convenstions.
  internal           = true #app_alb is  private loadbalencer. bydefault=false(public)
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.app_alb_sg_id.value]
  subnets            = split(",", data.aws_ssm_parameter.private_subnet_ids.value) # load balencer required min 2 subnets.

  enable_deletion_protection = false # no need 

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.id
    prefix  = "test-lb"
    enabled = true
  }

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment_name}-app-alb"


  }) 
    
  
}

# add the listener resource  #google: alb listener terraform
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"  # http...not required certificates.
  
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>This is Fixed response from app ALB</h1>"  # our application is not ready so we give fixed response.
      status_code  = "200"
    }
}
}

# for DNS user friendly we create R58 record
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_name = var.zone_name
  
  records = [
    {
      name    = "*.app-${var.environment}"
      type    = "A"
      allow_overwrite = true
      alias   = {
        name    = aws_lb.app_alb.dns_name # dns name in console of aws
        zone_id = aws_lb.app_alb.zone_id
      }
    }
  ]
}
