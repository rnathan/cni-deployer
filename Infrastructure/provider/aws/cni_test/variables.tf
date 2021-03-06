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
variable admin_role_names {
  description = "List of IAM role names with AWS admin privileges on created resources"
  type        = list(string)
  default     = [
    "PCSKAdministratorAccessRole"
  ]
}
variable flow_logs_retention_in_days {
  description = "Retention period in days for VPC flow logs"
  type        = number
  default     = 30
}
variable authorizer_id {
  description = "ID of an existing authorizer. Omitting this field will default to no authorization on API endpoints."
  type        = string
  default     = ""
}
variable monitoring_s3_bucket_arn {
  description = "ARN of the bucket which stores the input json files for cni-monitoring."
  type        = string
  default     = "*"
}
variable bucket_name {
  description = "Name of the S3 bucket in which objects are stored. Omitting this field defaults to a value of \"sfdc-cni-artifacts-{env_name}-{region}\"."
  type        = string
  default     = ""
}
variable lambda_layer_s3_key {
  description = "Name of the lambda layer object in the S3 bucket"
  type        = string
}
variable lambda_layer_s3_object_version {
  description = "Version of the object in the S3 bucket used to create the lambda layer. Omitting this field defaults to the latest version."
  type        = string
  default     = ""
}
variable lambda_function_s3_key {
  description = "Name of the lambda function object in the S3 bucket"
  type        = string
}
variable lambda_function_s3_object_version {
  description = "Version of the object in the S3 bucket used to create the lambda function. Omitting this field defaults to the latest version."
  type        = string
  default     = ""
}
variable lambda_memory_size {
  description = "Memory to allocate for each lambda function in MB"
  type        = number
  default     = 256
}
variable sfdc_vpn_cidrs {
  description = "List of SFDC VPN CIDRs for access whitelisting"
  type        = list(string)
  default     = ["204.14.239.0/24","13.110.54.0/24"]  # AmerWest and AmerWest1
}
variable kaiju_agent_cidrs {
  description = "List of Kaiju Agent CIDRs for access whitelisting"
  type        = list(string)
  default     = ["34.204.119.37/32", "34.225.218.148/32", "34.225.187.88/32", "52.5.215.92/32",    # Heroku Virginia
                 "54.249.107.199/32", "18.179.67.175/32", "13.112.84.84/32", "52.196.166.80/32",   # Heroku Tokyo
                 "52.212.82.183/32", "34.246.233.208/32", "34.254.138.50/32", "34.254.145.177/32", # Heroku Dublin
                 "13.238.81.165/32", "13.238.131.20/32", "13.237.246.34/32", "13.210.28.44/32",    # Heroku Sydney
                 "3.120.4.237/32", "18.197.232.248/32", "52.57.11.174/32", "3.120.7.69/32",        # Heroku Frankfurt
                 "52.89.186.231/32", "54.202.153.27/32", "54.69.101.88/32", "35.161.249.213/32"]   # Heroku Oregon
}
variable inbound_vpc_cidr {
  description = "CIDR of the inbound VPC"
  type        = string
  default     = "10.20.8.0/22"
}
variable outbound_vpc_cidr {
  description = "CIDR of the outbound VPC"
  type        = string
  default     = "10.20.12.0/22"
}
variable monitoring_vpc_cidr {
  description = "CIDR of the monitoring VPC"
  type        = string
  default     = "172.16.0.0/24"
}
variable monitoring {
  description = "Information of CNI monitoring dcoker image"
  type        = object({
    image     = string
    version   = string
  })
}
variable az_count {
  description = "Number of availability zones to deploy to"
  type        = number
  default     = 3
}
variable monitoring_instance_type {
  description = "Type of monitoring instance"
  type        = string
  default     = "t2.small"
}
variable enable_inbound_nat_gateway {
  description = "If true, enables creation of a NAT gateway for each public subnet in the inbound VPC"
  type        = bool
  default     = true
}
variable enable_outbound_nat_gateway {
  description = "If true, enables creation of a NAT gateway for each public subnet in the outbound VPC"
  type        = bool
  default     = true
}
variable enable_monitoring_nat_gateway {
  description = "If true, enables creation of a NAT gateway for each public subnet in the monitoring VPC"
  type        = bool
  default     = true
}
variable enable_inbound_private_nat_routes {
  description = "If true, creates routes in private subnet route tables to route traffic to a NAT gateway. Has no effect is NAT gateways are not enabled."
  type        = bool
  default     = true
}
variable enable_outbound_private_nat_routes {
  description = "If true, creates routes in private subnet route tables to route traffic to a NAT gateway. Has no effect is NAT gateways are not enabled."
  type        = bool
  default     = true
}
variable enable_monitoring_private_nat_routes {
  description = "If true, creates routes in private subnet route tables to route traffic to a NAT gateway. Has no effect is NAT gateways are not enabled."
  type        = bool
  default     = true
}
variable write_local_pem_files {
  description = "If true, writes generated private keys as local pem files in the directory of the root module"
  type        = bool
  default     = true
}
variable inbound_vpc_private_subnet_cidrs {
  description = "List of the CIDRs to use for the inbound VPC private subnets"
  type        = list(string)
  default     = []
}
variable inbound_vpc_public_subnet_cidrs {
  description = "List of the CIDRs to use for the inbound VPC public subnets"
  type        = list(string)
  default     = []
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
variable monitoring_vpc_private_subnet_cidrs {
  description = "List of the CIDRs to use for the monitoring VPC private subnets"
  type        = list(string)
  default     = []
}
variable monitoring_vpc_public_subnet_cidrs {
  description = "List of the CIDRs to use for the monitoring VPC public subnets"
  type        = list(string)
  default     = []
}
variable inbound_data_plane_node_group_instance_types {
  description = "Set of instance types to associate with the inbound data plane node group"
  type        = list(string)
  default     = ["t3.medium"]
}
variable inbound_data_plane_node_group_desired_size {
  description = "The number of hosts desired for the inbound data plane node group"
  type        = number
  default     = 3
}
variable inbound_data_plane_node_group_max_size {
  description = "The maximum number of hosts to create in the inbound data plane node group"
  type        = number
  default     = 3
}
variable inbound_data_plane_node_group_min_size {
  description = "The minimum number of hosts to create in the inbound data plane node group"
  type        = number
  default     = 3
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
