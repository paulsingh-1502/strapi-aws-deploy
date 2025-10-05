# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-cluster"
}

# IAM Role for ECS Task
resource "aws_iam_role" "ecs_task_execution" {
  name = "${var.app_name}-task-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_attach" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "strapi" {
  family                   = var.app_name
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([{
    name      = var.app_name
    image     = "${aws_ecr_repository.strapi.repository_url}:latest"
    essential = true
    portMappings = [{
      containerPort = var.container_port
      hostPort      = var.container_port
    }]
  }])
}

# ECS Service
resource "aws_ecs_service" "strapi" {
  name            = var.app_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.strapi.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = aws_subnet.public[*].id
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.strapi.arn
    container_name   = var.app_name
    container_port   = var.container_port
  }

  depends_on = [aws_lb_listener.http]
}
