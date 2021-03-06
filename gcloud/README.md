# PrivX on GCP 
This project simplifies PrivX on-boarding experience with deployment automation using Infrastructure as a Code (terraform).


## Description:
This repo contains terraform code to spin 1 Compute Instance on GCP for PrivX evaluation purposes.
An additional Compute instance for PrivX Carrier and PrivX WebProxy can be spin by setting `enable_web` to `true`

* Postgresql Database : Local on same server

* Redis Cache  : Local on same server

* PrivX Server :  Centos8 AMI used for this VM and PrivX installation and configuration are being done as post build steps.

* ssh_user : Username `centos` can be used for ssh to virtual machine

* PrivX Web : An additional Compute instance will spin, PrivX Carrier and PrivX Web Proxy installation will be done if value for `enable_web` set to `true` (default: false)

## Pre-requisites : Install/Configure Google Cloud SDK and Terraform and update variables

1. Install [Git](https://git-scm.com/downloads)
1. Install [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) and Run `gcloud init` to initialize the SDK.
1. Install [Terraform](https://www.terraform.io/).


#### Mandatory variables to be updated (create terraform.tfvars file and populate value for below listed variables)
```
# GCP project id
project-id = "my-project"

# GCP region
region = "europe-west2"

# GCP zone
zone = "europe-west2-b"
```

**Note:** private_key file should be created outside git repo as these files contain confidential data (private_key).

#### Optional variables: Default value for optional variable can be changed in variable.tf file (check variables.tf for all variables)
```
# Machine type for Privx (default = e2-medium)
machine_typeprivx = "e2-medium"

# Machine type for Privx Web (default = e2-medium)
machine_typeprivxweb = "e2-medium"

# Privx superuser name
privx_superuser = "admin"

#Public key to setup password less authentication for centos user on target Virutal machines
ssh_pub_key_file = "~/.ssh/id_rsa.pub"

# Private key path for key data specified above, Update private key path
ssh_private_key_file = "~/.ssh/id_rsa"

# SSH public key data for terraform cloud, leave as null if using ssh_pub_key_file
ssh_pub_key_data = null

# SSH Private key data for terraform cloud, leave as null if using ssh_private_key_file
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