# Configure the Azure provider
provider "azurerm" {
  # for production deployments it's wise to fix the provider version
  #version = "~>1.32.0"

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id   
}

# Create a new resource group
resource "azurerm_resource_group" "rg" {
    name     = var.basename
    location = var.azurelocation
	
    tags = {
        environment = var.envtype
    }
}

# Create an App Service Plan with Linux
resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "${azurerm_resource_group.rg.name}-APPPLAN"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Define Linux as Host OS
  kind = "Linux"
  reserved = true # Mandatory for Linux plans

  # Choose size
  # https://azure.microsoft.com/en-us/pricing/details/app-service/linux/
  sku {
    tier = var.SKUtier
    size = var.SKUsize
  }
}

# Create an Azure Web App for Containers in that App Service Plan
resource "azurerm_app_service" "appsvc" {
  name                = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id

  # Do not attach Storage by default
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false

    /*
    # Settings for private Container Registires  
    DOCKER_REGISTRY_SERVER_URL      = ""
    DOCKER_REGISTRY_SERVER_USERNAME = ""
    DOCKER_REGISTRY_SERVER_PASSWORD = ""
    */
  }

  # Configure Docker Image to load on start
  site_config {
    linux_fx_version = "DOCKER|${var.DockerImage}"
    #always_on        = "false"
    #ftps_state       = "FtpsOnly"
  }

  logs {
    http_logs {
      file_system {
        retention_in_days = var.logdays
        retention_in_mb   = var.logsizemb
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }
}

output "DockerUrl" {
    value = azurerm_app_service.appsvc.default_site_hostname
}
