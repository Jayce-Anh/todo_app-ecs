############################## VARIABLES ##############################

#------------ACM------------#
variable "domain_alb" {type = string}
variable "domain_s3cf" {type = string}
variable "region_s3cf" {
  type = string
  default = "us-east-1"
}

#------------Secret Manager------------#
variable "secret_name" {type = string}
variable "recovery_window_in_days" {
  type = number
  default = 30
}

#------------Parameter Store------------#
# variable "parameter_store_services" {
#   type = list(string)
# }

#------------ECR------------#
variable "ecr_force_destroy" {
  type = bool
  default = true
}
variable "source_services" {
  type = list(string)
  default = ["be"]
}

