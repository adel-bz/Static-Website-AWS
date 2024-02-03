# Static Website on AWS with Terraform

# Introduction

This repository contains Terraform scripts to set up a static website on AWS using Amazon S3 and Amazon CloudFront.
Also, It has used Cloudflare and Amazon ACM to manage Domain and SSL Certification.

![Screenshot from 2024-01-23 10-46-29](https://github.com/adel-bz/Static-Website-AWS/assets/45201934/ea1d8c4f-524a-47d5-83ce-ac80763351e8)


# Prerequisites

Before you begin, make sure you have the following prerequisites:

- [Terraform](https://www.terraform.io/) installed on your local machine.
- Cloudflare account with a domain and Cloudflare API [token](https://developers.cloudflare.com/fundamentals/api/get-started/create-token/).
- AWS credentials configured with the necessary [permissions](https://github.com/adel-bz/Static-Website-AWS#permissions).
> **Note:**
> You can't use ".ir" domain name, Amazon ACM doesn't accept it.

 #### Install aws-vault on Ubuntu: 

```
$ sudo curl -L -o /usr/local/bin/aws-vault https://github.com/99designs/aws-vault/releases/latest/download/aws-vault-linux-amd64
$ sudo chmod 755 /usr/local/bin/aws-vault
```
 #### Install aws-vault on other OS:
 https://github.com/99designs/aws-vault

 #### To store AWS credentials for use, enter:
```
$ aws-vault add <profile>
```

# Permissions
You need some permissions for your IAM user that you want to work with that to make your progress.
#### Services
- Amazon S3
- DynamoDB
- CloudFront
- ACM
- WAF V2

#### Resources
- Your DynamoDB table ARN
- All Resources for other Services

![Untitled design](https://github.com/adel-bz/Static-Website-AWS/assets/45201934/e54a379a-ef26-4dd1-8a9c-415ef6d8e5a1)

# Usage

### Step 1:
clone the repository:
```
$ sudo git clone https://github.com/adel-bz/Static-Website-AWS.git
```
### Step 2:
In the second step, You should create a DynamoDB table and S3 bucket. like this link: https://spacelift.io/blog/terraform-s3-backend

Also, go to "backend.tf" file then change the terraform backend block and import your information.

### Step 3:
Change Variables in variables.tf

### Step 4:
Run these commands step by step:
```
$ terraform init
$ terraform workspace new production # To create the production environment, you can change it to dev, stage, or any environment you want.
$ terraform fmt
$ terraform validate
$ terraform plan
$ terraform apply

## If you want to destroy your infrastructure, use:
$ terraform destroy
```
![domain example com (1)](https://github.com/adel-bz/Static-Website-AWS/assets/45201934/dd2a588a-dd45-43f6-b437-b235e0efe42f)
# Contributing

Contributions are welcome! Follow these steps to contribute:
1. Fork the repository.
2. Create a new branch: ```git checkout -b feature-name``` 
3. Make your changes and commit them: ```git commit -m 'Add feature'```
4. Push to the branch: ```git push origin feature-name```
5. Submit a pull request.
