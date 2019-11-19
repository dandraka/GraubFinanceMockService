basename = "graubfinancemock"

# when logging in as a user via Azure CLI, these values must be null
subscription_id = null
client_id       = null
client_secret   = null
tenant_id       = null

envtype = "test"

# this can change depending on your preferences
# you can get location codes using
# az account list-locations
# e.g. try "eastus" or "centralindia"
azurelocation = "westeurope"

# Using the free tier generates an error.
# Seems that Microsoft does not want people to
# use their resources *completely* free?
# Who knew! :-)
#SKUtier = "Free"
#SKUsize = "F1"

# This is still very cheap though
SKUtier = "Basic"
SKUsize = "B1"

DockerImage = "YOURUSERNAME/graubfinancemock:latest"

logdays = 30
logsizemb = 30
