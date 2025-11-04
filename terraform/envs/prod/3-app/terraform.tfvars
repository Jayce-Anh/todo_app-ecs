####################### VARIABLES VALUES #####################
#---------Bastion---------#
enabled_eip = true
instance_type = "t3a.small"
instance_name = "bastion"
iops = 3000
volume_size = 30
path_user_data = "${path.root}/scripts/user_data/user_data.sh"
key_name = "lab-jayce"
sg_ingress = {
  rule1 = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Connect to bastion"
  }
  rule2 = {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    description = "Connect to RDS MySQL"
  }
}

# #---------External LB---------#
# lb_name = "ex-alb"
# source_ingress_sg_cidr = ["0.0.0.0/0"]
# target_groups = {
#   be = {
#     name              = "be"
#     service_port      = 5000
#     health_check_path = "/health"
#     priority          = 1
#     host_header       = "todo-be.jayce-lab.work"
#     target_type       = "ip"
#     ec2_id            = null
#   }
# }

# #---------ACM---------#
# # Certificate for ALB
# domain_alb = "*.jayce-lab.work"
# # Certificate for CloudFront
# domain_s3cf = "*.jayce-lab.work"
# region_s3cf = "us-east-1"


# #------------CloudFront---------#
# service_name = "todo-fe"
# cloudfront_domain = "todo-fe.jayce-lab.work"
# cloudfront_force_destroy = true
# custom_error_response = {
#   "403" = {
#     error_code         = 403
#     response_code      = 200
#     response_page_path = "/index.html"
#   }
#   "404" = {
#     error_code         = 404
#     response_code      = 200
#     response_page_path = "/index.html"
#   }
# }

# #---------ECR---------#
# ecr_force_destroy = true
# source_services = ["be"]

# #---------RDS---------#
# rds_name = "mysql-db"
# rds_multi_az = false
# rds_storage_type = "gp3"
# rds_iops = 3000
# rds_throughput = 125
# rds_storage = 30
# rds_max_storage = 100
# rds_username = "admin"  # Update with actual username
# rds_password = "changeme"  # Update with actual password (use sensitive values)
# rds_class = "db.t4g.small"
# rds_engine = "mysql"
# rds_engine_version = "8.0"
# rds_port = 3306
# rds_backup_retention_period = 7
# performance_insights_retention_period = 0
# rds_family = "mysql8.0"
# aws_db_parameters = {
#   "max_connections"          = 500
#   "require_secure_transport" = 0
# }

# #---------Redis---------#
# redis_name = "redis"
# redis_engine = "redis"
# redis_engine_version = "6.2"
# redis_port = 6379
# redis_num_cache_nodes = 1
# redis_node_type = "cache.t4g.small"
# redis_snapshot_retention_limit = 1
# redis_family = "redis6.x"
# allowed_cidr_blocks_access_redis = []
# redis_parameters = {
#   "maxmemory-policy" = "allkeys-lru"
# }

# #---------Secret Manager---------#
# secret_name = "secret"

# #---------Parameter Store---------#
# parameter_store_services = ["be", "fe"]

# #---------ECS---------#
# ecs_task_definitions = {
#   "be" = {
#     container_name       = "be"
#     container_image      = "701604998432.dkr.ecr.us-east-1.amazonaws.com/prod-todo-be:latest"
#     desired_count        = 1
#     cpu                  = 1024  # 1 vCPU
#     memory               = 2048  # 2 GB RAM
#     container_port       = 5000
#     host_port            = 5000
#     health_check_path    = "/health"
#     enable_load_balancer = true
#     load_balancer = {
#       target_group_port = 5000
#       container_port    = 5000
#     }
#   }
# }

