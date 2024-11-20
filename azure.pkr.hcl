variable "subscription_id" {
    type = string
    default = "05d81944-2379-4f99-aba1-2ac9e52529b5"
}

variable "tenant_id" {
    type = string
    default = "bdf6fa44-c7b1-44e4-83af-4442716a5a1c"
}

variable "client_id" {
    type = string
    default = "aa946c00-caa1-4d1d-8aac-2f76542b786b"
}

variable "client_secret" {
    type = string
    default = "Yik8Q~wiffTYekq2X1iDn.BBvqtUwhky.4yF0bPp"
}

variable "image_name" {
    type = string
    default = "packer-windows-image1"
}

variable image_version {
    type = string
    default = "2.0.0"
}

source "azure-arm" "windows" {
    client_id = var.client_id
    client_secret = var.client_secret
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
    managed_image_name = "${var.image_name}-${var.image_version}"
    managed_image_resource_group_name = "PackerImage"
    vm_size = "Standard_D2_v2"
    temp_resource_group_name = "PackerBuild"
    location = "Central India"
    
    os_type = "Windows"
    image_publisher = "MicrosoftWindowsServer"
    image_offer = "WindowsServer"
    image_sku = "2019-Datacenter"

    communicator    = "winrm"
    winrm_use_ssl   = true
    winrm_insecure  = true
    winrm_timeout   = "5m"
    winrm_username  = "packer"
}