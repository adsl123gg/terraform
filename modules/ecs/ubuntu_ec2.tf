resource "aws_ecs_cluster" "ec2_cluster" {
  name = "ecs-ec2-cluster"
  /*
  capacity_providers = [aws_ecs_capacity_provider.ecs_provider_asg.name]
  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_provider_asg.name
    weight = 10
    base = 1
  }
 */
}

data "aws_ecs_task_definition" "ubuntu" {
  task_definition = aws_ecs_task_definition.ubuntu.family
}

resource "aws_ecs_task_definition" "ubuntu" {
  family                = "ubuntu-ec2"
  container_definitions = file("${path.module}/task-definitions/ubuntu.json")
  network_mode          = "host"
  //network_mode             = "bridge"
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["EC2"]
}

resource "aws_ecs_service" "ubuntu_service" {
  name            = "ubuntu_service"
  cluster         = aws_ecs_cluster.ec2_cluster.id
  task_definition = "${aws_ecs_task_definition.ubuntu.family}:${aws_ecs_task_definition.ubuntu.revision}"
  desired_count   = 1
}

resource "aws_network_interface" "ecs-vpc-ni" {
  subnet_id       = var.ecs_subnet_id
  security_groups = [var.ecs_sg]
}

output "ua" {
  value = aws_ecs_cluster.ec2_cluster.id
}
output "ub" {
  value = aws_ecs_task_definition.ubuntu.revision
}

