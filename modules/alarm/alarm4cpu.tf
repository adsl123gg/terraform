data "aws_instance" "example" {
  filter {
    name   = "tag:Name"
    values = ["ubuntu"]
  }
}

resource "aws_cloudwatch_metric_alarm" "alarm4cpu" {
  alarm_name                = "terraform-alarm4cpu"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
  dimensions = {
    InstanceId = data.aws_instance.example.id
  }
}

resource "aws_cloudformation_stack" "stack_alarm4cpu" {
  name          = "stackAlarm4cpu"
  template_body = file("${path.module}/cf/cpu-cf.yaml")
  //template_url = "https://hqcbucket.s3.eu-central-1.amazonaws.com/terraform/cpu-cf.yaml"
}
