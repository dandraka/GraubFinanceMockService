terraform init
# here you need to see stuff happening and then
# "Terraform has been successfully initialized!"
terraform plan -out="out.plan" -var-file="service-varvalues-dev.tfvars"
# if everything went well, apply
terraform apply "out.plan"