variable "project" {
  type = object({
    env = string
    name = string
    region = string
    account_id = number
  })
}

variable "tags" {
  type = object({
    Name = string
    env = string
  })
}

variable "region" {
  type = string
}

variable "domain" {
  type = string
}

