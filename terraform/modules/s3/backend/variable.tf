##################### VARIABLES #####################
variable "project" {
  type = object({
    name = string
    env = string
    region = string
    account_ids = list(number)
  })
}

variable "tags" {
  type = object({
    Name = string
  })
}

variable "sse_algorithm" {
  type = string
  description = "Server-side encryption algorithm"
  default = "AES256"
}