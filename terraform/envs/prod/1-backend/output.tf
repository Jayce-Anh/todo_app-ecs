##################### OUTPUTS #####################

output "bucket_name" {
  description = "The name of the S3 bucket for Terraform state"
  value       = module.backend.bucket_name
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.backend.bucket_arn
}
