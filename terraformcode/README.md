1. export the access key and secret as the environment variables so that Terraform can connect to your account

2. Place this entire content under /root/terraformcode on any linux environment (We can change this path in script though)

3. All the variables are under vars.tf which will control the count of instances and the message on index.html hosted on nginx

4. This solution will create the ubuntu EC2 instance and install nginx along with the required config



6. Change the key_name in main.tf as per your account

7. Please the corresponding public key (.pem file ) in the same directory.

8. Modify the names of file

9. Run the following commands

terraform init
terraform plan
terraform apply


