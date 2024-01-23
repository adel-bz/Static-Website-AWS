# Static Website on AWS with Terraform

# Introduction

This repository contains Terraform scripts to set up a static website on AWS using Amazon S3 and Amazon CloudFront.
Also, It has used Cloudflare and Amazon ACM to manage Domain and SSL Certification.

# Prerequisites

Before you begin, make sure you have the following prerequisites:

- [Terraform](https://www.terraform.io/) installed on your local machine.
- Cloudflare account with a domain and Cloudflare API [token](https://developers.cloudflare.com/fundamentals/api/get-started/create-token/).
> **Note:**
> You can't use ".ir" domain name, Amazon ACM doesn't accept it.
- AWS credentials configured with the necessary permissions.

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

