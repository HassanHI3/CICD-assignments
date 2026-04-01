terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0.0"
    }
  }

  backend "s3" {
    bucket       = "terraform-assignment-101"
    key          = "terraform/state/my-python-appp.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
  }
}



provider "aws" {
  region = "eu-west-2"
}

resource "aws_ecr_repository" "task-2" {
  name                 = "bar"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

data "aws_iam_role" "ecs_execution_role" {
  name = "ecsTaskExecutionRole"
}

resource "aws_ecs_cluster" "task_2" {
  name = "white-hart"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "test" {
  family                   = "test"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = data.aws_iam_role.ecs_execution_role.arn

  container_definitions = <<TASK_DEFINITION
[
  {
    "name": "my-app",
    "image": "891377356090.dkr.ecr.eu-west-2.amazonaws.com/my-app:latest",
    "cpu": 1024,
    "memory": 2048,
    "essential": true
  }
]
TASK_DEFINITION
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "my_app_sg" {
  name        = "my-app-sg"
  description = "Security group for my ECS service"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Allow app traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_service" "my_app_ecs_service" {
  name            = "my-app"
  cluster         = aws_ecs_cluster.task_2.id
  task_definition = aws_ecs_task_definition.test.arn
  desired_count   = 3
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.default.ids
    security_groups  = [aws_security_group.my_app_sg.id]
    assign_public_ip = true
  }
}
