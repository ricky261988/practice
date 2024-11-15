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