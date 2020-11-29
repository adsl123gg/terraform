resource "aws_autoscaling_group" "ec2_asg" {
  name             = "ec2_asg"
  max_size         = 2
  min_size         = 0
  desired_capacity = 1
  //availability_zones = [var.aws_region]
  //launch_configuration = data.aws_launch_configuration.ecs_asg_lc.name
  vpc_zone_identifier = [data.aws_subnet.ec2_subnet_id.id]
  launch_template {
    id      = data.aws_launch_template.foobar.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = ""
    propagate_at_launch = true
  }

}

data "aws_subnet" "ec2_subnet_id" {
  id = var.ec2_subnet_id
}

data "aws_launch_template" "foobar" {
  name = "foobar"
}

/*
data "aws_launch_configuration" "ecs_asg_lc" {
  name   = "EC2ContainerService-ec2-cluster-EcsInstanceLc-YZZIWO1H8YXB"
}

resource "aws_ecs_capacity_provider" "ecs_provider_asg" {
  name = "ec2_provider_asg"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ec2_asg.arn
    //managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}
*/
