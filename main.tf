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
  domain_name1 = aviatrix_aws_tgw_security_domain.onprem_domain.name
  domain_name2 = aviatrix_aws_tgw_security_domain.aviatrix_edge_domain.name
}

resource "aviatrix_aws_tgw_transit_gateway_attachment" "default" {
  tgw_name             = aviatrix_aws_tgw.default.tgw_name
  region               = var.region
  vpc_account_name     = var.account
  vpc_id               = var.transit_gw.vpc_id
  transit_gateway_name = var.transit_gw.gw_name
}

resource "aviatrix_aws_tgw_directconnect" "default" {
  tgw_name                   = aviatrix_aws_tgw.default.tgw_name
  directconnect_account_name = var.account
  dx_gateway_id              = coalesce(var.dx_gateway_id, aws_dx_gateway.default[0].id)
  security_domain_name       = aviatrix_aws_tgw_security_domain.onprem_domain.name
  allowed_prefix             = var.allowed_prefix
}