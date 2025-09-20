variable "env" {
  type = string
}

variable "region" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}

variable "eks_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "node_group_name" {
  type = string
}

variable "instance_types" {
  default = ["t4g.medium"]
  type    = list(string)
}

variable "ami_type" {
  type    = string
  default = "AL2023_ARM_64_STANDARD"
}

variable "eks_addon_metrics_server_version" {
  type    = string
  default = "3.12.1"
}

variable "eks_addon_pod_identity_agent_version" {
  type    = string
  default = "v1.3.7-eksbuild.2"
}

variable "autoscaler_helm_chart_version" {
  type    = string
  default = "9.46.6"
}

variable "ingress_nginx_helm_chart_version" {
  type    = string
  default = "4.12.3"
}

variable "aws_lbc_version" {
  type    = string
  default = "1.13.3"
}

variable "cert_manager_helm_chart_version" {
  type    = string
  default = "v1.18.1"
}

variable "aws_ebs_csi_driver_version" {
  default = "v1.44.0-eksbuild.1"
}
