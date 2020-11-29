data "aws_ecs_cluster" "ecs_cluster" {
  cluster_name = "default"
}

data "aws_ecs_task_definition" "nginx" {
  task_definition = aws_ecs_task_definition.nginx.family
}

resource "aws_ecs_task_definition" "nginx" {
  family                   = "first-run-task-definition"
  container_definitions    = file("${path.module}/task-definitions/nginx.json")
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  requires_compatibilities = ["FARGATE"]
}

resource "aws_ecs_service" "nginx_service" {
  name            = "nginx_service"
  cluster         = data.aws_ecs_cluster.ecs_cluster.id
  task_definition = "${aws_ecs_task_definition.nginx.family}:${max(aws_ecs_task_definition.nginx.revision, data.aws_ecs_task_definition.nginx.revision)}"
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [var.ecs_subnet_id]
    security_groups  = [var.ecs_sg]
    assign_public_ip = true
  }
}

output "a" {
  value = aws_ecs_task_definition.nginx.family
}
output "b" {
  value = aws_ecs_task_definition.nginx.revision
}
output "c" {
  value = data.aws_ecs_task_definition.nginx.revision
}

