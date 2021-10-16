## Terraform VPC & EC2 

To create the infrastructure in AWS and run GoPhish as a Service it will be necessary to have:

[Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) installed
[AWS programmatic credeials](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html)
A domain in Cloudflare managed together with the Management API Key.

# Create the Host A and save the ZONE_ID & ID

[Follow this Tutorial](https://www.tech-otaku.com/web-development/using-cloudflare-api-manage-dns-records/#413)

# Clone the proyect and enter to /VPC
````
git clone https://github.com/safernandez666/Terraform.git && cd Terraform
cd vpc

````
# Configure 📌

You must change the variables on **install.sh** 

```
API_EMAIL="XXXX"
API_KEY="XXXX"
RECORD_NAME="netflix.XXXX.XXX.XX"
ZONE_ID="XXXX"
RECORD_ID="XXXX"

```

# Prepare de VPC with the server
````
terraform init
terraform plan
terraform apply -auto-approved

````

Check the Output. You will have the address to connect by ssh to the instance. Then it will be necessary to know the default password of GoPhish.

<p align="center">
<img src="screenshots/outputs.png" width="800" >
</p>