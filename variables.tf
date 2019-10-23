# variables.tf

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "eu-west-1"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "remik/remik_node:green"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 8080
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = "2"
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 2
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}

variable "domain" {
  description = "Domain that needs to be registered in AWS Route53 where I will add A alias that points to ECS"
  default = "boguszewicz.net"
}

variable "zone_id" {
  description = "Hosted Zone ID (NOT ELB Hosted Zone ID) to be found in Route53 / Hosted zones"
  default = "ZN6B8XIYIX51"
}

variable "tag_name" {
  description = "Tag to easily identify created resources"
  default     = "remi-test-tf"
}
