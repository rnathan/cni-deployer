variable region {
  type = string
}
variable env_name {
  type = string
}
variable deployment_id {
  type = string
}
variable tags {
  type = map(string)
}
variable admin_role_names {
  type = list(string)
  default = [
    "PCSKAdministratorAccessRole"
  ]
}
variable private_connect_role_name {
  description = "Name to use for the customer-facing Private Connect IAM role"
  type        = string
  default     = ""
}
variable write_local_pem_files {
  description = "If true, writes generated private keys as local pem files in the directory of the root module"
  type        = bool
  default     = true
}
variable sitebridge_config {
  description = <<EOT
    gateway_ips - List of Sitebridge Openswan VPN connection IPs
  EOT
  type = object({
    bgp_asn           = string
    gateway_ips       = list(string)
  })
}