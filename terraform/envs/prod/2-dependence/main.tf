############################ DEPENDENCE ########################

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

#---------Secret Manager---------#
module "secret_manager" {
  source      = "../../../modules/secret_manager"
  project     = local.project
  tags        = local.tags
  secrets = {
    be = {
      secret_name = var.secrets.be.secret_name
      use_initial_value = var.secrets.be.use_initial_value
      secret_data = var.secrets.be.secret_data
    }
    fe = {
      secret_name = var.secrets.fe.secret_name
      use_initial_value = var.secrets.fe.use_initial_value
      secret_data = var.secrets.fe.secret_data
    } 
    github_token = {
      secret_name = var.secrets.github_token.secret_name
      use_initial_value = var.secrets.github_token.use_initial_value
      secret_data = var.secrets.github_token.secret_data
    }
  }
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

#---------Bastion---------#
module "bastion" {
  source                     = "../../../modules/ec2"
  project                    = local.project
  tags                       = local.tags
  enabled_eip                = var.enabled_eip
  instance_type              = var.instance_type
  instance_name              = var.instance_name
  iops                       = var.iops
  volume_size                = var.volume_size
  vpc_id                     = data.terraform_remote_state.network.outputs.vpc_id
  source_ingress_ec2_sg_cidr = var.source_ingress_ec2_sg_cidr
  path_user_data             = var.path_user_data
  key_name                   = var.key_name
  subnet_id                  = data.terraform_remote_state.network.outputs.public_subnet_ids[0]

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