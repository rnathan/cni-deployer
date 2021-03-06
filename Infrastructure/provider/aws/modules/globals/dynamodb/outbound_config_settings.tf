resource aws_dynamodb_table outbound_config_settings {
  name             = "${var.resource_prefix}_OutboundConfigSettings"
  billing_mode     = "PAY_PER_REQUEST"
  hash_key         = local.outbound_config_hash_key
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  server_side_encryption {
    enabled = true
  }

  point_in_time_recovery {
    enabled = var.enable_point_in_time_recovery
  }

  attribute {
    name = local.outbound_config_hash_key
    type = "S"
  }

  tags = var.tags
}
