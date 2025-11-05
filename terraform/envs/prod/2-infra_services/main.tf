######################### INFRA SERVICES ##########################

#---------ACM---------#
#Certificate for ALB
module "acm_alb" {
  source  = "../../../modules/acm"
  project = local.project
  tags    = local.tags
  domain  = var.domain_alb
  region  = local.project.region
}

#Certificate for CloudFront
module "acm_s3cf" {
  source  = "../../../modules/acm"
  project = local.project
  tags    = local.tags
  domain  = var.domain_s3cf
  region  = local.project.region
}

#---------SECRET MANAGER---------#
module "secret_manager" {
  source      = "../../../modules/secret_manager"
  project     = local.project
  tags        = local.tags
  secret_name = var.secret_name
}

#---------PARAMETER STORE---------#
# module "parameter_store" {
#   source          = "../../../modules/parameter_store"
#   project         = local.project
#   tags            = local.tags
#   source_services = var.source_services
# }

#---------ECR---------#
module "ecr" {
  source          = "../../../modules/ecr"
  project         = local.project
  tags            = local.tags
  s3_force_del    = var.ecr_force_destroy
  source_services = var.source_services
}