# PrivX on AWS 
This project simplifies PrivX on-boarding experience with deployment automation using Infrastructure as a Code (terraform).


## Description:
This repo contains terraform code to spin 1 EC2 instance on AWS for PrivX evaluation purposes. 
An additional instance for PrivX Carrier and PrivX WebProxy can be spin by setting `enable_web` to `true`

* Postgresql Database : Local on same server

* Redis Cache  : Local on same server

* PrivX Server : Centos8 AMI used for this instance and PrivX installation and configuration are being done as post build steps.

* ssh_user : Username `ec2-user` can be used for ssh to ec2-instance

* PrivX Web : An additional instance will spin, PrivX Carrier and PrivX Web Proxy installation will be done if value for `enable_web` set to `true` (default: false)

## Pre-requisites : Install/Configure Git, AWS CLI and Terraform and update variables

1. Install [Git](https://git-scm.com/downloads)
1. Install [AWS CLI](https://aws.amazon.com/cli/) and use `aws configure` command to configure it.
1. Install [Terraform](https://www.terraform.io/).

#### Mandatory variables to be updated (create terraform.tfvars file and populate value for below listed variables)
```
# AWS region to be used
region = "eu-west-2"

# AWS key pair name for SSH password less authentication.
key_name = "default-linux-key"
```

**Note:** private_key file should be created outside git repo as these files contain confidential data (private_key).

#### Optional variables: Default value for optional variable can be changed in variable.tf file (check variables.tf for all variables)
```
# EC2 instance type for Privx (default = t2.medium)
instance_typeprivx = "t2.medium"

# Privx superuser name
privx_superuser = "admin"

# Private key path for key name specified above (default = "~/.ssh/id_rsa") 
ssh_private_key_file = "~/.ssh/id_rsa"

# Private key data for terraform cloud, leave as null if using ssh_private_key_file (default = null)
ssh_private_key_data = null

# Launch and configure additional machine for Web http/https (default = false)
enable_web = false 
```

**Note:** RANDOM password for database and privx_superuser will be generated and included in output.

## Deployment
1. Run `terraform init`
1. Run `terraform plan`
1. If plan looks good, run `terraform apply`

In the final step, please obtain a [license code](https://info.ssh.com/privx-free-access-management-software) to activate your environment.

## Configuration steps for PrivX Carrier and PrivX Web Proxy

#### To activate a PrivX license with the online method:
1. Access the PrivX GUI and navigate to the Settings→License page.
2. Under the License code section, enter your license code, and click Update License.

PrivX automatically installs your license, which enables PrivX functionality according to your license subscription.

#### Create a Carrier and Web-Proxy configuration.
1. In the PrivX GUI navigate to Settings→Deployment→Deploy PrivX web-access gateways.
1. To create the configurations, click Add Web-Access Gateway. Provide at least the Name and Proxy Address for the configuration.
1. Download the configurations (required later for setting up Carriers and Web Proxies). To do this, click  next to your configuration, then click Download Carrier Config and Download Proxy Config.

#### Configure PrivX Carrier
1. Copy your Carrier-configuration file to your Carrier machine, to the following path:

   `/opt/privx/etc/carrier-config.toml`
1. To finalize setup and register the Carrier with PrivX, run:

   `/opt/privx/scripts/carrier-postinstall.sh`

#### Configure PrivX WebProxy
1. Copy the Web-Proxy configuration file to the machine, to the following location:

   `/opt/privx/etc/web-proxy-config.toml`
1. To finalize setup and register the Web Proxy with PrivX, run:

   ` /opt/privx/scripts/web-proxy-postinstall.sh`

## Next Steps
* [Getting Started with PrivX](https://privx.docs.ssh.com/docs)