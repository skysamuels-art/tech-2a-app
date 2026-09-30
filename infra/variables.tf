variable "region"          { default = "us-west-1" }
variable "cluster_name"    { default = "tc2-eks" }
# Check the EKS console for a currently supported version before applying
variable "cluster_version" { default = "1.33" }