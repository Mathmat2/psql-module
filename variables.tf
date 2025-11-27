variable "project_id" {
  description = "ID of the project to which the instance will be deployed"
  type        = string
}

variable "region" {
  description = "Region to which the insatnce will be deployed"
  type        = string
}

variable "name" {
  description = "Name of the instance"
  type        = string
}

variable "kms_key" {
  description = "KMS key used to encrypt the instance data"
  type        = string
}

variable "vpc" {
  description = "ID of the VPC to which the instance will be connected"
  type        = string
}

variable "database_version" {
  description = "Database Postgresql version to use. By default use POSTGRES_17"
  type        = string
  nullable    = false

  validation {
    condition     = contains(["POSTGRES_13", "POSTGRES_14", "POSTGRES_15", "POSTGRES_16", "POSTGRES_17"], var.database_version)
    error_message = "Invalid value for database version. Use one of the following: POSTGRES_13, POSTGRES_14, POSTGRES_15, POSTGRES_16 or POSTGRES_17"
  }

  default = "POSTGRES_17"
}

variable "database_tier" {
  description = "Tier of the instance. By default db-f1-micro (614MiB RAM & 3TiB Disk)"
  type        = string
  default     = "db-f1-micro"
}

variable "cloud_sql_auth_proxy_usage" {
  description = "Indicates if SQL Auth proxy is to be used with this instance"
  type        = bool
  default     = true
}

variable "max_disk_size" {
  description = "Max disk size of the instance. If not set, disk size is tied to the instance tier"
  type        = number
  default     = 0
}

variable "deletion_protection" {
  description = "Used to allow deletion of the instance"
  type        = bool
  default     = true
}