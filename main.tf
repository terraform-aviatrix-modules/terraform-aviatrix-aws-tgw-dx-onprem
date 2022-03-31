resource "aviatrix_aws_tgw" "default" {
  account_name                      = var.account
  aws_side_as_number                = var.aws_asn
  manage_vpc_attachment             = false
  manage_transit_gateway_attachment = false
  manage_security_domain            = false
  region                            = var.region
  tgw_name                          = var.name != "" ? var.name : "tgw_${var.region}"
}

resource "aviatrix_aws_tgw_security_domain" "default_domain" {
  name     = "Default_Domain"
  tgw_name = aviatrix_aws_tgw.default.tgw_name
}

resource "aviatrix_aws_tgw_security_domain" "shared_service_domain" {
  name     = "Shared_Service_Domain"
  tgw_name = aviatrix_aws_tgw.default.tgw_name
}

resource "aviatrix_aws_tgw_security_domain" "aviatrix_edge_domain" {
  name     = "Aviatrix_Edge_Domain"
  tgw_name = aviatrix_aws_tgw.default.tgw_name
}

resource "aviatrix_aws_tgw_security_domain" "onprem_domain" {
  name     = "Onprem_Domain"
  tgw_name = aviatrix_aws_tgw.default.tgw_name
}

resource "aviatrix_aws_tgw_security_domain_connection" "cntonprem" {
  tgw_name     = aviatrix_aws_tgw.default.tgw_name
  domain_name1 = aviatrix_aws_tgw_security_domain.Onprem_Domain.name
  domain_name2 = aviatrix_aws_tgw_security_domain.Aviatrix_Edge_Domain.name
}

resource "aviatrix_aws_tgw_transit_gateway_attachment" "transit_attachmenet" {
  tgw_name             = aviatrix_aws_tgw.default.tgw_name
  region               = var.region
  vpc_account_name     = var.account
  vpc_id               = data.terraform_remote_state.tgw.outputs.transit_gw.vpc_id
  transit_gateway_name = data.terraform_remote_state.tgw.outputs.transit_gw.gw_name
}

resource "aviatrix_aws_tgw_directconnect" "vopak_aws_tgw_directconnect" {
  tgw_name                   = aviatrix_aws_tgw.default.tgw_name
  directconnect_account_name = var.account
  dx_gateway_id              = var.dx_gateway_id
  security_domain_name       = aviatrix_aws_tgw_security_domain.onprem_domain.name
  allowed_prefix             = var.allowed_prefix
}