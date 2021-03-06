variable region {
  description = "Name of the AWS region to deploy to"
  type        = string
}
variable env_name {
  description = "Name of the environment to deploy to"
  type        = string
  default     = "test"
}
variable deployment_id {
  description = "Short ID used to further distinguish a deployment. Must be less than 10 characters."
  type        = string
}
variable tags {
  description = "Map of tags used to annotate each resource supporting tags"
  type        = map(string)
}
variable flow_logs_retention_in_days {
  description = "Retention period in days for VPC flow logs"
  type        = number
  default     = 30
}
variable sfdc_vpn_cidrs {
  description = "List of SFDC VPN CIDRs for access whitelisting"
  type        = list(string)
  default = [
    # AmerWest
    "204.14.239.17/32",
    "204.14.239.18/32",
    "204.14.239.13/32",
    "204.14.239.105/32",
    "204.14.239.106/32",
    "204.14.239.107/32",
    "204.14.239.82/32",
    # AmerWest1
    "13.110.54.0/26",
    # CodeBuild(usw1, usw2, use1, use2)
    "13.56.32.200/29",
    "52.43.76.88/29",
    "34.228.4.208/28",
  "52.15.247.208/29"]
}

variable "outbound_vpcs_config" {
  type = map
}

variable az_count {
  description = "Number of availability zones to deploy to"
  type        = number
  default     = 3
}
variable enable_outbound_nat_gateway {
  description = "If true, enables creation of a NAT gateway for each public subnet in the outbound VPC"
  type        = bool
  default     = true
}
variable enable_outbound_private_nat_routes {
  description = "If true, creates routes in private subnet route tables to route traffic to a NAT gateway. Has no effect is NAT gateways are not enabled."
  type        = bool
  default     = true
}
variable outbound_data_plane_node_group_instance_types {
  description = "Set of instance types to associate with the outbound data plane node group"
  type        = list(string)
  default     = ["t3.medium"]
}
variable outbound_data_plane_node_group_desired_size {
  description = "The number of hosts desired for the outbound data plane node group"
  type        = number
  default     = 3
}
variable outbound_data_plane_node_group_max_size {
  description = "The maximum number of hosts to create in the outbound data plane node group"
  type        = number
  default     = 3
}
variable outbound_data_plane_node_group_min_size {
  description = "The minimum number of hosts to create in the outbound data plane node group"
  type        = number
  default     = 3
}
variable enable_sitebridge {
  description = "If false, skips creating resources related to Sitebridge."
  type        = bool
  default     = true
}
variable sitebridge_config {
  description = <<EOT
    control_plane_ips - List of Sitebridge control plane IPs
    data_plane_cidrs  - List of Sitebridge NAT pool CIDRs
    forwarded_domains - List of domains to route using a Sitebridge VPN connection
  EOT
  type = object({
    control_plane_ips = list(string)
    data_plane_cidrs  = list(string)
    forwarded_domains = list(string)
  })
  default = {
    control_plane_ips = []
    data_plane_cidrs  = []
    forwarded_domains = []
  }
}
variable vpc_suffix {
  type = string
}
variable eks_k8s_version {
  type        = string
  default     = "1.16"
  description = "Desired Kubernetes master version. If version is not specified in the manifest, the default version is used at resource creation"
}
