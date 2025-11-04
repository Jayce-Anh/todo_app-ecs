############################### SECRET MANAGER - VARIABLE ###############################
variable "project" {
  type = object({
    name = string
    env  = string
    region = string
    account_ids = list(number)
  })
}

variable "tags" {
  type = object({
    Name = string
  })
}

variable "secret_name" {
  type        = string
  description = "Name of the secret-manager"
}

variable "recovery_window_in_days" {
  type        = number
  description = "Number of days AWS waits before deleting the secret"
  default     = 30
}
