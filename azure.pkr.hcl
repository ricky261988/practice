source "azure-arm" "windows" {
    client_id = var.AZURE_CLIENT_ID
    client_secret = var.AZURE_CLIENT_SECRET
    subscription_id = var.AZURE_SUBSCRIPTION_ID
    tenant_id = var.AZURE_TENANT_ID
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