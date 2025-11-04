############################## VARIABLES ##############################
#---------Bastion---------#
variable "enabled_eip" {
  type = bool
  default = true
}
variable "instance_type" {type = string}
variable "instance_name" {type = string}
variable "iops" {type = number}
variable "volume_size" {
  type = number
  default = 30
}
variable "path_user_data" {type = string}
variable "key_name" {type = string}
variable "sg_ingress" {
  type = object({
    rule1 = object({
      from_port   = number
      to_port     = number
      protocol    = string
      description = string
    })
    rule2 = object({
      from_port   = number
      to_port     = number
      protocol    = string
      description = string
    })
  })
}

#---------External LB---------#
variable "lb_name" {type = string}
variable "source_ingress_sg_cidr" {type = list(string)}
variable "target_groups" {type = map(object({
  name              = string
  service_port      = number
  health_check_path = string
  priority          = number
  host_header       = string
  target_type       = string
  ec2_id            = string
}))}

#---------ACM---------#
# Certificate for ALB
variable "domain_alb" {type = string}
# Certificate for CloudFront
variable "domain_s3cf" {type = string}
variable "region_s3cf" {type = string}

#---------CloudFront---------#
variable "service_name" {type = string}
variable "cloudfront_domain" {type = string}
variable "cloudfront_force_destroy" {
  type = bool
  default = true
}
variable "custom_error_response" {
  type = map(object({
    error_code         = number
    response_code      = number
    response_page_path = string
  }))
}

#---------ECR---------#
variable "ecr_force_destroy" {
  type = bool
  default = true
}
variable "source_services" {
  type = list(string)
  default = ["be"]
}

#---------RDS---------#
variable "rds_name" {type = string}
variable "rds_multi_az" {
  type = bool
  default = false
}
variable "rds_storage_type" {type = string}
variable "rds_iops" {type = number}
variable "rds_throughput" {type = number}
variable "rds_storage" {type = number}
variable "rds_max_storage" {type = number}
variable "rds_username" {type = string}
variable "rds_password" {
  type = string
  sensitive = true
}
variable "rds_class" {type = string}
variable "rds_engine" {type = string}
variable "rds_engine_version" {type = string}
variable "rds_port" {type = number}
variable "rds_backup_retention_period" {type = number}
variable "performance_insights_retention_period" {type = number}
variable "rds_family" {type = string}
variable "aws_db_parameters" {
  type = map(any)
}

#---------Redis---------#
variable "redis_name" {type = string}
variable "redis_engine" {type = string}
variable "redis_engine_version" {type = string}
variable "redis_port" {type = number}
variable "redis_num_cache_nodes" {type = number}
variable "redis_node_type" {type = string}
variable "redis_snapshot_retention_limit" {type = number}
variable "redis_family" {type = string}
variable "allowed_cidr_blocks_access_redis" {
  type = list(string)
  default = []
}
variable "redis_parameters" {
  type = map(string)
}

#---------Secret Manager---------#
variable "secret_name" {type = string}
variable "recovery_window_in_days" {
  type = number
  default = 30
}

#---------Parameter Store---------#
variable "parameter_store_services" {
  type = list(string)
}

#---------ECS---------#
variable "ecs_task_definitions" {
  type = map(object({
    container_name       = string
    container_image      = string
    desired_count        = number
    cpu                  = number
    memory               = number
    container_port       = number
    host_port            = number
    health_check_path    = string
    enable_load_balancer = bool
    load_balancer = object({
      target_group_port = number
      container_port    = number
    })
  }))
}

