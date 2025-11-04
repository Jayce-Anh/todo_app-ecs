variable "project" {
  type = object({
    name       = string
    env        = string
    region     = string
    account_ids = list(number)
  })
}

variable "tags" {
  type = object({
    Name = string
  })
}


variable "URL_GG_HOOK" {
  type = string
}