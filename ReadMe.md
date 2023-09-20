### Instructions

1. Install Terraform CLI
2. Install AWS CLI
3. Create IAM User with "EC2 Full Access Poilcy" and create an aws access key to configure the aws in CLI 
4. In AWS CLI, Setup "aws configure" with the created AWS Access Key
5. Create a key-pair for the ssh connection.

After Setting up all these, write the provider.tf and main.tf files in the terraform folder

-> Move the website build folder to the same file


## Main.tf

1. In this file, create the EC2 Resource of name "Narne" with the key-pair and also attach the security group that is going to be created.
2. Create a another resource "website" for the file provisioning and for the execution of sh commands. Also create the ssh connection.
3. CReate the security group "webSG" too in the "website" resource with ingress port 22 and 80.


After, following all these, run the following:

1. terrafrom init
2. terraform plan
3. terrafrom apply


If you want to destroy the resources, use
4. terraform destroy