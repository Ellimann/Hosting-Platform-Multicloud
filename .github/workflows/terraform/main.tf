########################################
# AWS Instance
########################################
resource "aws_instance" "web_aws" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 (example)
  instance_type = "t2.micro"

  tags = {
    Name = "multi-cloud-aws"
  }
}

########################################
# Azure VM
########################################
resource "azurerm_resource_group" "rg" {
  name     = "rg-multicloud"
  location = "East US"
}

resource "azurerm_linux_virtual_machine" "vm_azure" {
  name                = "vm-multicloud"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s"
  admin_username      = "azureuser"

  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  network_interface_ids = []
}

########################################
# GCP VM
########################################
resource "google_compute_instance" "vm_gcp" {
  name         = "vm-multicloud"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}
