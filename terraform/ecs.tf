# MEDUSA ECS CLUSTER
resource "aws_ecs_cluster" "medusa_cluster" {
  name = "medusa-cluster"

  tags = {
    Name = "Medusa ECS Cluster"
  }
}

# MEDUSA TASK DEFIFNITION
resource "aws_ecs_task_definition" "medusa_task" {
  family                   = "medusa-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role-db.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role-db.arn

  container_definitions = jsonencode([
    {
      name      = "medusa-server"
      image     = "<IMAGE_TAG>"
      portMappings = [
        {
          containerPort = 9000
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          # DB CONNECTION STRING
          name  = "DATABASE_URL"
          value = "postgresql://${aws_db_instance.medusa_postgres.username}:${aws_db_instance.medusa_postgres.password}@${aws_db_instance.medusa_postgres.endpoint}:5432/${aws_db_instance.medusa_postgres.db_name}"
        },
        {
          # TLS REJECT UNAUTHORIZED
          name  = "NODE_TLS_REJECT_UNAUTHORIZED"
          value = "0"
        }
      ]
    },
  ])
}

# MEDUSA ECS SERVICE
resource "aws_ecs_service" "medusa_service" {
  name            = "medusa-service"
  cluster         = aws_ecs_cluster.medusa_cluster.id
  task_definition = aws_ecs_task_definition.medusa_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
    security_groups = [aws_security_group.medusa_ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.medusa_tg.arn
    container_name   = "medusa-server"
    container_port   = 9000
  }

  depends_on = [
    aws_lb_listener.http_listener
  ]
}
