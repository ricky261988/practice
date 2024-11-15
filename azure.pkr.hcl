variable "subscription_id" {
    type = string
    default = "${env("subscription_id")}"
}

variable "tenant_id" {
    type = string
    default = "${env("tenant_id")}"
}

variable "client_id" {
    type = string
    default = "${env("client_id")}"
}

variable "client_secret" {
    type = string
    default = "${env("client_secret")}"
}

variable "image_name" {
    type = string
    default = "packer-windows-image"
}

variable image_version {
    type = string
    default = "1.0.0"
}

source "azure-arm" "windows" {
    client_id = var.client_id
    client_secret = var.client_secret
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
    managed_image_name = "${var.image_name}-${var.image_version}"
    managed_image_resource_group_name = "PackerImage"
    vm_size = "Standard_D2_v2"
    location = "centralindia"

    virtual_network_name = "vm1-vnet"
    virtual_network_subnet_name = "default"
    virtual_network_resource_group_name = "PackerImage"
    private_virtual_network_with_public_ip = true
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

build {
  sources = [
    "source.azure-arm.windows"
  ]
    provisioner "powershell" {
      inline = [
        "Set-ExecutionPolicy Bypass -Scope Process -Force",
        "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
      ]
    }

    provisioner "windows-restart" {
      restart_check_command = "powershell -command \"& {Write-Output 'restarted.'}\""
    }

    provisioner "powershell" {
      inline = [
        "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit",
        "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Write-Output $imageState.ImageState; Start-Sleep -s 10  } else { break } }"
      ]
    }
}