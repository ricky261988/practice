variable "azure_subscription_id" {
    type = string
}

variable "azure_tenant_id" {
    type = string
}

variable "azure_client_id" {
    type = string
}

variable "azure_client_secret" {
    type = string
}

variable "image_name" {
    type = string
    default = "packer-windows-image"
}

variable image_version {
    type = string
    default = "1.0.0"
}