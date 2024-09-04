# AWS Access Key
variable "access_key" {
  description = "AWS Access Key"
  type        = string
}

# AWS Secret Key
variable "secret_key" {
  description = "AWS Secret Key"
  type        = string
}

# AWS Token Key
variable "token_key" {
  description = "AWS Token Key"
  type        = string
}

# VPC ID for the EC2 instances
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

# AMI ID for the EC2 instances
variable "ami_id" {
  description = "AMI ID"
  type        = string
}

# SSH Key Name
variable "key_name" {
  description = "Key Name"
  type        = string
}

# SSH User for Ansible
variable "ssh_user" {
  description = "SSH User"
  type        = string
}

# Path to the SSH Private Key
variable "private_key_path" {
  description = "Path to the SSH Private Key"
  type        = string
}

# Number of instances to create (excluding master)
variable "total_instances" {
  description = "Number of instances"
  type        = number
  default     = 1
}

#AWS regions can be set for the availability zones.
variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
}

#subnet_id variable acquired from EC2 Dashboard.
variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instances will be launched."
  type        = string
}

# Path to the install_docker.yml playbook
#variable "install_docker_source" {
#  description = "Path to the install_docker.yml playbook"
#  type        = string
#}

# Path to the install_jenkins.yml playbook
variable "install_jenkins_source" {
  description = "Path to the install_jenkins.yml playbook"
  type        = string
}

# Path to the install_kubernetes.yml playbook
#variable "install_kubernetes_source" {
#  description = "Path to the install_kubernetes.yml playbook"
#  type        = string
#}

# Path to the install_kubernetes.yml playbook
variable "install_dock_kube_tools_source" {
  description = "Path to the install_dock_kube_tools_source.yml playbook"
  type        = string
}

# Path to the setup_kubernetes_master.yml playbook
variable "setup_kubernetes_master_source" {
  description = "Path to the setup_kubernetes_master.yml playbook"
  type        = string
}

# Path to the setup_worker.yml playbook
variable "setup_kubernetes_worker_source" {
  description = "Path to the setup_workers playbook"
  type        = string
}
