variable "subscription_id" {
    type = string
}

variable "tenant_id" {
    type = string
}

variable "client_id" {
    type = string
}

variable "client_secret" {
    type = string
}

variable "image_name" {
    type = string
    default = "packer-windows-image1"
}

variable image_version {
    type = string
    default = "2.0.0"
}