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
  default     = ["204.14.239.0/24", "13.110.54.0/24"] # AmerWest and AmerWest1
}
variable outbound_vpc_cidr {
  description = "CIDR of the outbound VPC"
  type        = string
  default     = "10.20.12.0/22"
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
variable outbound_vpc_private_subnet_cidrs {
  description = "List of the CIDRs to use for the outbound VPC private subnets"
  type        = list(string)
  default     = []
}
variable outbound_vpc_public_subnet_cidrs {
  description = "List of the CIDRs to use for the outbound VPC public subnets"
  type        = list(string)
  default     = []
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
variable vpc_suffix {
  type = string
}
