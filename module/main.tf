# module app {
#     source = "../Class2"
#     # source = "github"
#     # source = terraform registry
# }


module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  # Autoscaling group
  name = "example-asg"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  availability_zones       = ["us-east-1a","us-east-1b"]
  # Launch template
  launch_template_name        = "example-asg"
  launch_template_description = "Launch template example"
  update_default_version      = true
  image_id          = "ami-02f3f602d23f1659d"
  instance_type     = "t3.micro"
  ebs_optimized     = false
  enable_monitoring = false
}