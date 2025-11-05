############################### SECRET MANAGER - OUTPUT ###############################

output "secret_name" {
  description = "Name of the secret-manager"
  value = aws_secretsmanager_secret.secret.name
}

output "secret_arn" {
  description = "ARN of the secret-manager"
  value       = aws_secretsmanager_secret.secret.arn
}

output "secret_id" {
  description = "ID of the secret-manager"
  value       = aws_secretsmanager_secret.secret.id
}

output "secret_version_id" {
  description = "Version ID of the secret"
  value       = try(
    aws_secretsmanager_secret_version.secret_with_ignore[0].version_id,
    aws_secretsmanager_secret_version.secret_managed[0].version_id
  )
}


