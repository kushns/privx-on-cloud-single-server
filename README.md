# PrivX on Cloud: Single Server
This project simplifies PrivX on-boarding experience with deployment automation using Infrastructure as a Code (terraform) on below Cloud platforms.
* AWS
* AZURE
* GCP

## Description:
This repo contain terraform code to spin 1 centos8 server on selected/all cloud platform for PrivX evaluation purposes.
An centos8 server for PrivX Carrier and PrivX WebProxy can be spin by setting `enable_web` to `true`

* Postgresql Database : Local on same server

* Redis Cache  : Local on same server

* PrivX Server :  Centos8 image used for this instance and PrivX installation and configuration are being done as post build steps.

* ssh_user: Username `ec2-user` on AWS and `centos` on Azure and GCP can be used for ssh to centos8 host

* PrivX Web : Centos8 image will be used for PrivX Carrier and PrivX Web Proxy installation, if value for `enable_web` set to `true` (default: false)

## Pre-requisites : Install/Configure Git, Cloud provider CLI and Terraform and update variables

1. Install [Git](https://git-scm.com/downloads)
1. Install [Terraform](https://www.terraform.io/)
1. Install and configure CLI for Cloud Provider you want to use.
   
    a) AWS: Install [AWS CLI](https://aws.amazon.com/cli/) and use `aws configure` command to configure it.
    
    b) AZURE: Install [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) and use `azure login` command to configure it.
    
    c) GCP: Install [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) and Run `gcloud init` to initialize the SDK.


### Mandatory variables to be updated (create terraform.tfvars file and populate value for below listed variables)
**Note:** All Mandatory variables default value is set to `null`. Populate/overwrite variables value for Cloud Provider you want to use.    
#### AWS
```
    # AWS region to be used
    region = "eu-west-2"
    
    # AWS key pair name for SSH password less authentication.
    key_name = "default-linux-key"
```
#### Azure
```
    # Azure region
    azure_region = "uksouth"
```
#### GCP
```
    # GCP project id
    gcp_project-id = "my-project"  
    
    # GCP region
    gcp_region = "europe-west2"
    
    # GCP zone
    gcp_zone = "europe-west2-b"
```

### Optional variables: Default value for optional variable can be changed in variable.tf file 
```
    # Privx superuser name (default = admin)
    privx_superuser = "admin"
     
    # EC2 instance type for Privx (default = t2.medium) 
    aws_instance_type = "t2.medium"
    
    # EC2 instance type for Privx Web (default = t2.medium) 
    aws_instance_type_web = "t2.medium"
    
    # Azure vmsize for PrivX (default = Standard_DS1_v2)
    azure_vmsize = "Standard_DS1_v2"
    
    # Azure vmsize for PrivX Web (default = Standard_DS1_v2)
    azure_web_vmsize = "Standard_DS1_v2"
        
    # GCP machine type for PrivX (default = e2-medium)
    gcp_machine_type = "e2-medium"
    
    # GCP machine type for PrivX Web (default = e2-medium)
    gcp_machine_type_web = "e2-medium"
    
    # SSH Private key path (default = ~/.ssh/id_rsa)
    ssh_private_key_file = "~/.ssh/id_rsa"
    
    # SSH public key path to setup password less authentication (default = ~/.ssh/id_rsa.pub)
    ssh_pub_key_file =  "~/.ssh/id_rsa.pub"
    
    # SSH public key data for terraform cloud, leave as null if using ssh_pub_key_file
    ssh_pub_key_data = null

    # SSH Private key data for terraform cloud, leave as null if using ssh_private_key_file
    ssh_private_key_data = null
    
    # Launch and configure additional machine for Web http/https (default = false)
    enable_web = false 
```
**Note:** ssh_private_key_file and ssh_pub_key_file files should be created outside git repo as these files contain credentials data.

**Note:** RANDOM password for database and privx_superuser will be generated and included in output along with login url.

## Deployment
1. Run `terraform init`
   

2. Run `terraform plan` with option `-target` to limit plan operation to single cloud provider module

   `terraform plan -target=module.aws` for AWS
   
   `terraform plan -target=module.azure` for Azure
   
   `terraform plan -target=module.gcloud` for GCO
   

3. If plan looks good, run `terraform apply` with option `-target` option to limit operation to single cloud provider module
   
   `terraform apply -target=module.aws` for AWS
   
   `terraform apply -target=module.azure` for Azure
   
   `terraform apply -target=module.gcloud` for GCO


4. On completion terraform output will include PrivX login URL and password for PrivX superuser (default user: admin), open url in any browser and login using credentials.
   
   ###### Sample execution output AWS 
   ```
   Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
   
   Outputs:
   
   aws-database_password  = "YaOu6L7lugQH7DsG=M9c"
   aws-privx-public-dns   = "https://ec2-3-9-164-8.eu-west-2.compute.amazonaws.com"
   aws-superuser_password = "KU@DyRnBVmu87S1Bm8_m"
   ```

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


**Note:** Once done with PrivX evaluation and evaluation infrastructure no longer requried `terraform destroy` can be used to destroy infrastructure.