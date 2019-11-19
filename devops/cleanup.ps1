param ([string]$rgName)

[bool]$rgExists = ((az group exists -n $rgName) -eq 'true')

if ($rgExists) 
{ 
        az group delete -n $rgName -y  
} 
else 
{ 
        Write-Host "Resource group $rgName does not exist, nothing to do"
}