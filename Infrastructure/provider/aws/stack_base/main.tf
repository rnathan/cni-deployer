terraform {
  backend s3 {}
}

provider aws {
  region = var.region
}

locals {
  resource_prefix = "${var.env_name}-${var.region}-${var.deployment_id}"
}

###############################
#  IAM
###############################

module iam {
  source                    = "../modules/iam"
  tags                      = var.tags
  region                    = var.region
  resource_prefix           = local.resource_prefix
  private_connect_role_name = var.private_connect_role_name
}

###############################
#  Transit Gateway
###############################

resource aws_ec2_transit_gateway default {
  tags = merge(var.tags, {Name: local.resource_prefix})
}

###############################
#  Customer Gateways
###############################

resource aws_customer_gateway default {
  tags       = merge(var.tags, {Name: "${local.resource_prefix}-${count.index}"})
  bgp_asn    = var.sitebridge_config.bgp_asn
  ip_address = trimsuffix(var.sitebridge_config.gateway_ips[count.index], "/32")
  type       = "ipsec.1"

  count      = length(var.sitebridge_config.gateway_ips)
}

###############################
#  VPN Connections
###############################

resource aws_vpn_connection default {
  tags                = merge(var.tags, {Name: "${local.resource_prefix}-${count.index}"})
  customer_gateway_id = aws_customer_gateway.default[count.index].id
  transit_gateway_id  = aws_ec2_transit_gateway.default.id
  type                = aws_customer_gateway.default[count.index].type

  count               = length(var.sitebridge_config.gateway_ips)
}

###############################
#  Outbound DNS Zone
###############################

module outbound_dns_zone {
  source          = "../modules/outbound_dns_zone"
  tags            = var.tags
  region          = var.region
  resource_prefix = "${local.resource_prefix}-outbound"
  zone_name       = "cni-outbound.salesforce.com"
}

###############################
#  Outbound Key Pairs
###############################

module outbound_bastion_key_pair {
  source               = "../modules/ec2_key_pair"
  tags                 = var.tags
  key_name             = "${local.resource_prefix}-bastion"
  write_local_pem_file = var.write_local_pem_files
}

module outbound_node_group_key_pair {
  source               = "../modules/ec2_key_pair"
  tags                 = var.tags
  key_name             = "${local.resource_prefix}-node-group"
  write_local_pem_file = var.write_local_pem_files
}