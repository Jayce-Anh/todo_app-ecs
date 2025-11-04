############################ BASTION ############################
module "bastion" {
  source                     = "../../../modules/ec2"
  project                    = local.project
  tags                       = local.tags
  enabled_eip                = var.enabled_eip
  instance_type              = var.instance_type
  instance_name              = var.instance_name
  iops                       = var.iops
  volume_size                = var.volume_size
  source_ingress_ec2_sg_cidr = data.terraform_remote_state.network.outputs.source_ingress_ec2_sg_cidr
  path_user_data             = var.path_user_data
  key_name                   = var.key_name
  subnet_id                  = data.terraform_remote_state.network.outputs.public_subnet_ids[0]
  alb_sg_id                  = module.alb.lb_sg_id

  sg_ingress = {
    rule1 = {
      from_port   = var.sg_ingress.rule1.from_port
      to_port     = var.sg_ingress.rule1.to_port
      protocol    = var.sg_ingress.rule1.protocol
      description = var.sg_ingress.rule1.description
    }
    rule2 = {
      from_port   = var.sg_ingress.rule2.from_port
      to_port     = var.sg_ingress.rule2.to_port
      protocol    = var.sg_ingress.rule2.protocol
      description = var.sg_ingress.rule2.description
    }
  }
}

# ############################ EXTERNAL LB ############################
# module "alb" {
#   source                 = "../../../modules/alb/external"
#   project                = var.project
#   tags                   = var.tags
#   lb_name                = var.lb_name
#   vpc_id                 = data.terraform_remote_state.network.outputs.vpc_id
#   dns_cert_arn           = module.acm_alb.cert_arn
#   subnet_ids             = data.terraform_remote_state.network.outputs.public_subnet_ids
#   source_ingress_sg_cidr = var.source_ingress_sg_cidr

#   target_groups = var.target_groups
# }

# ############################ ACM ############################
# #Certificate for ALB
# module "acm_alb" {
#   source  = "../../../modules/acm"
#   project = var.project
#   tags    = var.tags
#   domain  = var.domain_alb
#   region  = var.project.region
# }

# #Certificate for CloudFront
# module "acm_s3cf" {
#   source  = "../../../modules/acm"
#   project = var.project
#   tags    = var.tags
#   domain  = var.domain_s3cf
#   region  = var.region_s3cf
# }

# ########################### CLOUDFRONT ############################
# module "cloudfront" {
#   source                = "../../../modules/cloudfront"
#   project               = var.project
#   tags                  = var.tags
#   service_name          = var.service_name
#   cf_cert_arn           = module.acm_s3cf.cert_arn
#   s3_force_del          = var.cloudfront_force_destroy
#   cloudfront_domain     = var.cloudfront_domain
#   custom_error_response = var.custom_error_response
# }

# ############################# ECR ###################################
# module "ecr" {
#   source          = "../../../modules/ecr"
#   project         = var.project
#   tags            = var.tags
#   s3_force_del    = var.ecr_force_destroy
#   source_services = var.source_services
# }

# ############################# RDS #################################
# module "rds" {
#   source  = "../../../modules/rds"
#   project = var.project
#   network = data.terraform_remote_state.network.outputs
#   tags    = var.tags

#   rds_name = var.rds_name
#   db_name  = var.project.name
#   multi_az = var.rds_multi_az
#   allowed_sg_ids_access_rds = [
#     module.bastion.ec2_sg_id,
#     module.ecs.ecs_tasks_sg_id,
#   ]

#   rds_storage_type = var.rds_storage_type
#   rds_iops         = var.rds_iops
#   rds_throughput   = var.rds_throughput

#   rds_storage     = var.rds_storage
#   rds_max_storage = var.rds_max_storage

#   rds_username = var.rds_username
#   rds_password = var.rds_password

#   rds_class                             = var.rds_class
#   rds_engine                            = var.rds_engine
#   rds_engine_version                    = var.rds_engine_version
#   rds_port                              = var.rds_port
#   rds_backup_retention_period           = var.rds_backup_retention_period
#   performance_insights_retention_period = var.performance_insights_retention_period

#   rds_family        = var.rds_family
#   aws_db_parameters = var.aws_db_parameters
# }

# ############################ REDIS #################################
# module "redis" {
#   source                           = "../../../modules/redis"
#   project                          = var.project
#   network                          = data.terraform_remote_state.network.outputs
#   tags                             = var.tags
#   redis_name                       = var.redis_name
#   redis_engine                     = var.redis_engine
#   redis_engine_version             = var.redis_engine_version
#   redis_port                       = var.redis_port
#   redis_num_cache_nodes            = var.redis_num_cache_nodes
#   redis_node_type                  = var.redis_node_type
#   redis_snapshot_retention_limit   = var.redis_snapshot_retention_limit
#   redis_family                     = var.redis_family
#   allowed_cidr_blocks_access_redis = var.allowed_cidr_blocks_access_redis
#   allowed_sg_ids_access_redis = [
#     module.ecs.ecs_tasks_sg_id
#   ]
#   redis_parameters = var.redis_parameters
# }

# ############################# SECRET MANAGER ############################
# module "secret_manager" {
#   source      = "../../../modules/secret_manager"
#   project     = var.project
#   tags        = var.tags
#   secret_name = var.secret_name
# }

# ############################# PARAMETER STORE ############################
# module "parameter_store" {
#   source          = "../../../modules/parameter_store"
#   project         = var.project
#   tags            = var.tags
#   source_services = var.parameter_store_services
# }

# ################################ ECS #######################################
# module "ecs" {
#   source           = "../../../modules/ecs"
#   project          = var.project
#   tags             = var.tags
#   vpc_id           = data.terraform_remote_state.network.outputs.vpc_id
#   lb_sg_id         = module.alb.lb_sg_id
#   target_group_arn = module.alb.tg_arns["be"]
#   subnets          = data.terraform_remote_state.network.outputs.private_subnet_ids
#   task_definitions = var.ecs_task_definitions
# }