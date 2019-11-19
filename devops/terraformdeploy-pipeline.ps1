terraform init
terraform plan -out="out.plan" -var-file="service-varvalues-pipeline.tfvars"
terraform apply "out.plan"