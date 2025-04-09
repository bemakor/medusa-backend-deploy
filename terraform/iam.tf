# IAM ROLE FOR ECS TASKS
resource "aws_iam_role" "ecs_task_execution_role-db" {
  name = "ecsTaskExecutionRole-db"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

# ATTACHING TO ECS TASK
resource "aws_iam_role_policy_attachment" "ecs_task_execution_attach" {
  role       = aws_iam_role.ecs_task_execution_role-db.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

# IAM ROLE FOR CLOUDWATCH LOGGING
resource "aws_iam_role" "cloudwatch_logging_role" {
  name = "ecsCloudWatchLogsRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# ATTACHING TO CLOUDWATCH 
resource "aws_iam_role_policy_attachment" "cloudwatch_logs_policy" {
  role       = aws_iam_role.cloudwatch_logging_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
