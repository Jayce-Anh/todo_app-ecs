module "backend" {
  source      = "../../../modules/s3/backend"
  project     = local.project
  tags        = local.tags
}
