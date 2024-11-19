variable "AZURE_SUBSCRIPTION_ID" {
    type = string
}

variable "AZURE_TENANT_ID" {
    type = string
}

variable "AZURE_CLIENT_ID" {
    type = string
}

variable "AZURE_CLIENT_SECRET" {
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