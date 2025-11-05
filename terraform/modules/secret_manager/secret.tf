################################# SECRET MANAGER #################################

#Create secret
resource "aws_secretsmanager_secret" "secret" {
  name                    = "${var.project.env}-${var.project.name}-${var.secret_name}"
  recovery_window_in_days = var.recovery_window_in_days
  
  tags = merge(var.tags, {
    Name = "${var.project.env}-${var.project.name}-${var.secret_name}"
  })
}

#Create secret version with initial value (changes ignored)
resource "aws_secretsmanager_secret_version" "secret_with_ignore" {
  count = var.use_initial_value ? 1 : 0
  
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = "init"
  
  lifecycle {
    ignore_changes = [secret_string]
  }
}

#Create secret version with managed value (changes not ignored)
resource "aws_secretsmanager_secret_version" "secret_managed" {
  count = var.use_initial_value ? 0 : 1
  
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = jsonencode(var.secret_data)
}